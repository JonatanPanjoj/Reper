import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/frebase_group_datasource.dart';
import 'package:reper/infrastructure/repositories/group_respository_impl.dart';

final groupProvider = Provider((ref) {
  return GroupRepositoryImpl(FirebaseGroupDatasource());
});
