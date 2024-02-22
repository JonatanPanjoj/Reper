import 'dart:typed_data';

import 'package:reper/domain/entities/entities.dart';

abstract class RepertoryDatasource {
  Future<ResponseStatus> createRepertory({
    required Repertory repertory,
    required Uint8List image,
    required String groupId,
  });

  Future<ResponseStatus> updateRepertory({required Repertory repertory});

  Future<ResponseStatus> deleteRepertory({required String repId, required String groupId});

  Stream<List<Repertory>> streamRepertoriesById({required String repId});

  Stream<Repertory> streamRepertory({required String id, required String groupId});

  Future<ResponseStatus> createRepertorySection({required Repertory repertory, required String groupId});

}
