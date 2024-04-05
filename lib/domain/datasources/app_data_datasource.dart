import 'package:reper/domain/entities/entities.dart';

abstract class AppDataDatasource{
  Stream<AppData> streamAppData();
}