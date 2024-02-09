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
    required Uint8List image,
    required String groupId,
  }) async {
    try {
      final repertoryRef = await _database
          .collection('groups')
          .doc(groupId)
          .collection('repertories')
          .add(repertory.toJson());

      final String imageUrl = await uploadImageToStorage(
        fileName: repertoryRef.id,
        childName: 'repertories',
        mediaFile: image,
      );

      await repertoryRef.set(
          repertory.copyWith(id: repertoryRef.id, image: imageUrl).toJson());

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
  Future<ResponseStatus> deleteRepertory({required String repId}) {
    // TODO: implement deleteRepertory
    throw UnimplementedError();
  }

  @override
  Stream<List<Repertory>> streamRepertoriesById({required String repId}) {
    // TODO: implement streamRepertoriesById
    throw UnimplementedError();
  }

  @override
  Future<ResponseStatus> updateRepertory({required Repertory repertory}) {
    // TODO: implement updateRepertory
    throw UnimplementedError();
  }
}
