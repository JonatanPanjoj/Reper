import 'dart:typed_data';

import 'package:reper/domain/entities/entities.dart';

abstract class GroupDatasource {
  Future<ResponseStatus> createGroup({required Group group, required Uint8List mediaFile});

  Future<ResponseStatus> getUserGroups({required String uid});

  Future<ResponseStatus> updateGroup({required Group group});

  Future<ResponseStatus> deleteGroup({required String groupId});

  Stream<List<Group>> streamGroupsById({required List<String> groups});
}
