import 'package:reper/domain/datasources/app_data_datasource.dart';
import 'package:reper/domain/entities/app_data.dart';
import 'package:reper/domain/repositories/app_data_repository.dart';

class AppDataRepositoryImpl extends AppDataRepository{

  final AppDataDatasource datasource;

  AppDataRepositoryImpl(this.datasource);

  @override
  Stream<AppData> streamAppData() {
    return datasource.streamAppData();
  }

}