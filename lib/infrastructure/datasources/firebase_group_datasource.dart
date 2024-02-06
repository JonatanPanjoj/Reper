import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/datasources/group_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/datasources/firebase_user_datasource.dart';

class FirebaseGroupDatasource extends GroupDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseUserDatasource groupDatasource = FirebaseUserDatasource();

  @override
  Future<ResponseStatus> createGroup({
    required Group group,
    required Uint8List mediaFile,
  }) async {
    try {
      //Crear Group
      final groupRef = await _database.collection('groups').add(group.toJson());

      //Subir imagen a Storage
      final imageUrl = await uploadImageToStorage(
        fileName: groupRef.id,
        childName: 'groups',
        mediaFile: mediaFile,
      );

      await groupRef
          .set(group.copyWith(image: imageUrl, id: groupRef.id).toJson());

      //Obtener Usuario
      final user =
          await groupDatasource.getUserById(uid: _auth.currentUser!.uid);

      await groupDatasource.updateGroup(
          uid: _auth.currentUser!.uid, groupId: groupRef.id);

      //Agregar User a SubCollection Group
      if (user != null) {
        await _database
            .collection('groups')
            .doc(groupRef.id)
            .collection('users')
            .add(user.toJson());
      } else {
        return ResponseStatus(
          message: 'El usuario no se agregó',
          hasError: true,
        );
      }

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
  Future<ResponseStatus> deleteGroup({required String groupId}) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
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
    return _database
        .collection('groups')
        .where('id', whereIn: groups)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Group.fromJson(doc.data())).toList());
  }
}
