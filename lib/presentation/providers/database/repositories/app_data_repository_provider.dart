import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/firebase_app_data_datasource.dart';
import 'package:reper/infrastructure/repositories/app_data_repository_impl.dart';

final appDataRepositoryProvider = Provider((ref) => AppDataRepositoryImpl(
      FirebaseAppDataDatasource(),
    ));
