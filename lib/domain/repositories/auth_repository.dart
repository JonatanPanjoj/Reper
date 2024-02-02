import 'package:reper/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<ResponseStatus> loginByEmailAndPassword({
    required String email,
    required String password,
  });

  Future<ResponseStatus> registerByEmailAndPassword({
    required String nickname,
    required String email,
    required String password,
  });

  Future<void> signOut();
}
