import 'package:reper/domain/entities/entities.dart';

abstract class UserDatasource {
  Future<ResponseStatus> validateNickname({
    required String nickname,
  });

  Future<ResponseStatus> createUser({
    required AppUser user,
    required String uid,
  });
}
