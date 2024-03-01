import 'dart:typed_data';

import 'package:reper/domain/datasources/group_datasource.dart';
import 'package:reper/domain/entities/group.dart';
import 'package:reper/domain/entities/shared/response_status.dart';
import 'package:reper/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository{

  GroupDatasource datasource;

  GroupRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> createGroup({required Group group, required Uint8List mediaFile}) {
    return datasource.createGroup(group: group, mediaFile: mediaFile); 
  }

  @override
  Future<ResponseStatus> deleteGroup({required String groupId}) {
    return datasource.deleteGroup(groupId: groupId);
  }

  @override
  Future<ResponseStatus> getUserGroups({required String uid}) {
    return datasource.getUserGroups(uid: uid);
  }

  @override
  Future<ResponseStatus> updateGroup({required Group group}) {
    return datasource.updateGroup(group: group);
  }
  
  @override
  Stream<List<Group>> streamGroupsById({required List<String> groups}) {
    return datasource.streamGroupsById(groups: groups);
  }
  
  @override
  Future<ResponseStatus> deleteParticipant({required String uid, required groupId}) {
    return datasource.deleteParticipant(uid: uid, groupId: groupId);
  }

}