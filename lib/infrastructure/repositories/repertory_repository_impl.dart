import 'dart:typed_data';

import 'package:reper/domain/datasources/repertory_datasource.dart';
import 'package:reper/domain/entities/repertory.dart';
import 'package:reper/domain/entities/shared/response_status.dart';
import 'package:reper/domain/repositories/repertory_repository.dart';

class RepertoryRepositoryImpl extends RepertoryRepository {
  RepertoryDatasource datasource;

  RepertoryRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> createRepertory({
    required Repertory repertory,
    required Uint8List image,
    required String groupId,
  }) {
    return datasource.createRepertory(
      repertory: repertory,
      image: image,
      groupId: groupId,
    );
  }

  @override
  Future<ResponseStatus> deleteRepertory({required String repId, required String groupId}) {
    return datasource.deleteRepertory(repId: repId, groupId: groupId);
  }

  @override
  Stream<List<Repertory>> streamRepertoriesById({required String repId}) {
    return datasource.streamRepertoriesById(repId: repId);
  }

  @override
  Future<ResponseStatus> updateRepertory({required Repertory repertory}) {
    return datasource.updateRepertory(repertory: repertory);
  }
  
  @override
  Stream<Repertory> streamRepertory({required String id, required String groupId}) {
    return datasource.streamRepertory(id: id, groupId: groupId);
  }
}
