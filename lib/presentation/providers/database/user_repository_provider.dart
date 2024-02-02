import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/firebase_user_datasource.dart';
import 'package:reper/infrastructure/repositories/user_repository_impl.dart';

final userProvider = Provider((ref) {
  return UserRepositoryImpl(FirebaseUserDatasource());
});
