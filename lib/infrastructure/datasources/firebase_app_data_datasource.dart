import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reper/domain/datasources/app_data_datasource.dart';
import 'package:reper/domain/entities/app_data.dart';

class FirebaseAppDataDatasource extends AppDataDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Stream<AppData> streamAppData() {
    return _database.collection('app_data').doc('CHZJr9sknq01m7vqZah2').snapshots().map((snapshot) {
      return AppData.fromJson(snapshot.data()!);
    });
  }
}
