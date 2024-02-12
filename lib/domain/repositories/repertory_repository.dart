import 'dart:typed_data';

import 'package:reper/domain/entities/entities.dart';

abstract class RepertoryRepository {
  Future<ResponseStatus> createRepertory({
    required Repertory repertory,
    required Uint8List image,
    required String groupId,
  });

  Future<ResponseStatus> updateRepertory({required Repertory repertory});

  Future<ResponseStatus> deleteRepertory({required String repId, required String groupId});

  Stream<List<Repertory>> streamRepertoriesById({required String repId});
}
