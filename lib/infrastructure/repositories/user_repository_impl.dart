import 'package:reper/domain/datasources/user_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> validateNickname({
    required String nickname,
  }) {
    return datasource.validateNickname(nickname: nickname);
  }

  @override
  Future<ResponseStatus> createUser({
    required AppUser user,
    required String uid,
  }) {
    return datasource.createUser(user: user, uid: uid);
  }
}
