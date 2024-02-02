import 'package:reper/domain/datasources/auth_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> loginByEmailAndPassword(
      {required String email, required String password}) {
    return datasource.loginByEmailAndPassword(email: email, password: password);
  }

  @override
  Future<ResponseStatus> registerByEmailAndPassword({
    required String nickname,
    required String email,
    required String password,
  }) {
    return datasource.registerByEmailAndPassword(
      nickname: nickname,
      email: email,
      password: password,
    );
  }

  @override
  Future<ResponseStatus> loginWithGoogle() {
    return datasource.loginWithGoogle();
  }

  @override
  Future<void> signOut() {
    return datasource.signOut();
  }
}
