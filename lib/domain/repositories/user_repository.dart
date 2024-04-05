import 'dart:typed_data';

import 'package:reper/domain/entities/entities.dart';

abstract class UserRepository {
  Future<ResponseStatus> validateNickname({
    required String nickname,
  });

  Future<ResponseStatus> validateGoogleUser({
    required String id,
  });

  Future<ResponseStatus> createUser({
    required AppUser user,
    required String uid,
  });

  Future<AppUser?> getUserById({
    required String uid,
  });

  Future<ResponseStatus> updateUser({
    required AppUser user,
    Uint8List? image,
  });

    Future<ResponseStatus> updateGroup({
    required String uid,
    required String groupId,
  });

  Stream<AppUser?> streamUser({
    required String uid,
  });

  Stream<List<AppUser>> streamUserFriends({
    required List<String> friends,
  });
}
