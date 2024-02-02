import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/firebase_auth_datasource.dart';
import 'package:reper/infrastructure/repositories/auth_repository_impl.dart';

final authProvider = Provider((ref) {
  return AuthRepositoryImpl(FirebaseAuthDataSource());
});
