import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/firebase_repertory_datasource.dart';
import 'package:reper/infrastructure/repositories/repertory_repository_impl.dart';

final repertoryRepositoryProvider = Provider((ref) {
  return RepertoryRepositoryImpl(FirebaseRepertoryDatasource());
});
