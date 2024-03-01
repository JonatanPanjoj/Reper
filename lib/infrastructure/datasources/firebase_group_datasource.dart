import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/datasources/group_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/datasources/firebase_repertory_datasource.dart';

class FirebaseGroupDatasource extends GroupDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseRepertoryDatasource repertoryDatasource =
      FirebaseRepertoryDatasource();

  @override
  Future<ResponseStatus> createGroup({
    required Group group,
    required Uint8List mediaFile,
  }) async {
    try {
      final uid = _auth.currentUser!.uid;
      final WriteBatch batch = _database.batch();

      //Crear Referencia a Group
      final groupRef = _database.collection('groups').doc();
      final userRef = _database.collection('users').doc(uid);

      //Subir imagen a Storage
      final imageUrl = await uploadImageToStorage(
        fileName: groupRef.id,
        childName: 'groups',
        mediaFile: mediaFile,
      );

      //Agregamos el Grupo
      batch.set(
        groupRef,
        group.copyWith(image: imageUrl, id: groupRef.id).toJson(),
      );

      //Agregar User en Group y viceversa
      batch.update(groupRef, {
        'users': FieldValue.arrayUnion([_auth.currentUser!.uid])
      });
      batch.update(userRef, {
        'groups': FieldValue.arrayUnion([groupRef.id])
      });

      await batch.commit();

      return ResponseStatus(
        message: 'Grupo Creado con Éxito',
        hasError: false,
        extra: {
          'group': group.copyWith(image: imageUrl, id: groupRef.id).toJson()
        },
      );
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> deleteGroup({required String groupId}) async {
    try {
      final users = await _database
          .collection('users')
          .where('groups', arrayContains: groupId)
          .get();

      final WriteBatch batch = _database.batch();
      final groupRef = _database.collection('groups').doc(groupId);

      // Operaciones de lote
      batch.delete(groupRef);
      for (var doc in users.docs) {
        batch.update(doc.reference, {
          'tu_lista': FieldValue.arrayRemove([groupId])
        });
      }

      //TODO: CAMBIAR POR ELIMINAR GRUPOS Y REPERTORIOS

      await deleteAllGroupRepertories(groupId: groupId);
      await deleteImageFromStorage(fileName: groupId, childName: 'groups');

      batch.commit();

      return ResponseStatus(message: 'Grupo Creado Eliminado', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> getUserGroups({required String uid}) {
    // TODO: implement getUserGroups
    throw UnimplementedError();
  }

  @override
  Future<ResponseStatus> updateGroup({required Group group}) {
    // TODO: implement updateGroup
    throw UnimplementedError();
  }

  @override
  Stream<List<Group>> streamGroupsById({required List<String> groups}) {
    if (groups.isEmpty) {
      return Stream.value([]);
    }
    return _database
        .collection('groups')
        .where('id', whereIn: groups)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Group.fromJson(doc.data())).toList());
  }

  @override
  Future<ResponseStatus> deleteParticipant(
      {required String uid, required groupId}) async {
    try {
      final WriteBatch batch = _database.batch();

      final groupRef = _database.collection('groups').doc(groupId);
      final userRef = _database.collection('users').doc(uid);

      batch.update(groupRef, {
        'participants': FieldValue.arrayRemove([uid])
      });
      batch.update(userRef, {
        'groups': FieldValue.arrayRemove([groupId])
      });

      await batch.commit();

      return ResponseStatus(
          message: 'Participante eliminado con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

//OTROS
  Future<void> deleteSubcollectionDocs({
    required String collection,
    required String collectionId,
    required String subcollectionName,
  }) {
    return _database
        .collection(collection)
        .doc(collectionId)
        .collection(subcollectionName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<ResponseStatus> deleteAllGroupRepertories({
    required String groupId,
  }) async {
    try {
      WriteBatch batch = _database.batch();
      QuerySnapshot repertory = await FirebaseFirestore.instance
          .collection('groups/$groupId/repertories')
          .get();
      for (var doc in repertory.docs) {
        batch.delete(doc.reference);
        await repertoryDatasource.deleteAllRepertorySections(
          groupId: groupId,
          repertoryId: doc.id,
        );
      }
      batch.commit();
      for (var doc in repertory.docs) {
        await deleteImageFromStorage(
            fileName: doc.id, childName: 'repertories');
      }

      return ResponseStatus(
          message: 'Repertorios eliminados con exito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }
}
