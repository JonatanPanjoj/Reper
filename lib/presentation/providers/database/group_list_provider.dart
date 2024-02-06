import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/repositories/group_respository_impl.dart';
import 'package:reper/presentation/providers/providers.dart';

// Funciones Personalizadas

// Providers
final groupListProvider =
    StateNotifierProvider<GroupListNotifier, List<Group>>((ref) {
  final groupRepository = ref.watch(groupProvider);

  return GroupListNotifier(groupRepository: groupRepository);
});

// Controller / Bloc / Clase
class GroupListNotifier extends StateNotifier<List<Group>> {

  final GroupRepositoryImpl groupRepository;

  GroupListNotifier({required this.groupRepository}) : super([]);

  // Add Group
  Future<ResponseStatus> addGroup({
    required String groupName,
    required Uint8List mediaFile,
  }) async {
    final response = await groupRepository.createGroup(
        group: Group(
          id: 'no-id',
          name: groupName,
          image: 'no-image', 
        ),
        mediaFile: mediaFile);
    if (!response.hasError){
      state = [...state, Group.fromJson(response.extra!['group'])];
    }
    return response;
  }
}
