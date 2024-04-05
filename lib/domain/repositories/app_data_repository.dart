import 'package:reper/domain/entities/entities.dart';

abstract class AppDataRepository {
  Stream<AppData> streamAppData();
}
