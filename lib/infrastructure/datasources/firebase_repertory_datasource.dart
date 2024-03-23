import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/datasources/repertory_datasource.dart';
import 'package:reper/domain/entities/repertory.dart';
import 'package:reper/domain/entities/shared/response_status.dart';

class FirebaseRepertoryDatasource extends RepertoryDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<ResponseStatus> createRepertory({
    required Repertory repertory,
    required Uint8List? image,
    required String groupId,
  }) async {
    try {
      final WriteBatch batch = _database.batch();

// Crear una referencia al group y repertory
      final DocumentReference repertoryRef = _database
          .collection('groups')
          .doc(groupId)
          .collection('repertories')
          .doc();

      final DocumentReference groupRef =
          _database.collection('groups').doc(groupId);

      if (image != null) {
        // Subir la Imagen
        final String imageUrl = await uploadImageToStorage(
          fileName: repertoryRef.id,
          childName: 'repertories',
          mediaFile: image,
        );

        // Agregar el documento con la URL de la imagen
        batch.set(repertoryRef,
            repertory.copyWith(id: repertoryRef.id, image: imageUrl).toJson());
      }else{
        batch.set(repertoryRef,
            repertory.copyWith(id: repertoryRef.id).toJson());
      }

// Agregar ID a Group para saber la cantidad de reps
      batch.update(groupRef, {
        'repertories': FieldValue.arrayUnion([repertoryRef.id])
      });

      await batch.commit();

      return ResponseStatus(
        message: 'Se creó el repertorio correctamente',
        hasError: false,
      );
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> deleteRepertory({
    required String repId,
    required String groupId,
  }) async {
    try {
      final WriteBatch batch = _database.batch();

      final repertoryRef = _database
          .collection('groups')
          .doc(groupId)
          .collection('repertories')
          .doc(repId);
      final groupRef = _database.collection('groups').doc(groupId);

      batch.delete(repertoryRef);
      batch.update(groupRef, {
        'repertories': FieldValue.arrayRemove([repertoryRef.id])
      });
      await deleteImageFromStorage(fileName: repId, childName: 'repertories');

      await batch.commit();
      await deleteAllRepertorySections(groupId: groupId, repertoryId: repId);

      return ResponseStatus(
          message: 'Repertorio eliminado con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Stream<List<Repertory>> streamRepertoriesById({required String repId}) {
    return _database
        .collection('groups')
        .doc(repId)
        .collection('repertories')
        .orderBy('event', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Repertory.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<ResponseStatus> updateRepertory({required Repertory repertory}) async {
    try {
      final WriteBatch batch = _database.batch();

      final repertoryRef = _database
          .collection('groups')
          .doc(repertory.groupId)
          .collection('repertories')
          .doc(repertory.id);

      batch.update(repertoryRef, repertory.toJson());

      await batch.commit();

      return ResponseStatus(
          message: 'Repertorio actualizado con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Stream<Repertory> streamRepertory(
      {required String id, required String groupId}) {
    return _database
        .collection('groups')
        .doc(groupId)
        .collection('repertories')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      return Repertory.fromJson(snapshot.data()!..addAll({'id': snapshot.id}));
    });
  }

  @override
  Future<ResponseStatus> createRepertorySection(
      {required Repertory repertory, required String groupId}) async {
    try {
      final ref = _database
          .collection('groups')
          .doc(groupId)
          .collection('repertories')
          .doc(repertory.id)
          .collection('sections')
          .doc();
      await ref.set(repertory.toJson());

      return ResponseStatus(
          message: 'Repertorio actualizado con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  Future<ResponseStatus> deleteAllRepertorySections({
    required String groupId,
    required String repertoryId,
  }) async {
    try {
      WriteBatch batch = _database.batch();
      QuerySnapshot sections = await FirebaseFirestore.instance
          .collection('groups/$groupId/repertories/$repertoryId/sections')
          .get();
      for (var doc in sections.docs) {
        batch.delete(doc.reference);
      }

      batch.commit();

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
