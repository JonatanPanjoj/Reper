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
}
