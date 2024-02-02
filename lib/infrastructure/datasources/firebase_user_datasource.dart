import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reper/domain/datasources/user_datasource.dart';
import 'package:reper/domain/entities/entities.dart';

class FirebaseUserDatasource extends UserDatasource {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  @override
  Future<ResponseStatus> createUser({
    required AppUser user,
    required String uid,
  }) async {
    try {
      await database.collection('users').add(user.copyWith(uid: uid).toJson());
      return ResponseStatus(
          message: 'Usuario Creado con Éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> validateNickname({required String nickname}) async {
    final snapshot = await database
        .collection('users')
        .where('nickname', isEqualTo: nickname)
        .get();
    if (snapshot.docs.isEmpty) {
      return ResponseStatus(message: 'success', hasError: false);
    } else {
      return ResponseStatus(
        message: 'El nickname $nickname ya esta siendo utilizado',
        hasError: true,
      );
    }
  }

  @override
  Future<ResponseStatus> validateGoogleUser({required String id}) async {
    final snapshot = await database
        .collection('users')
        .where('google_id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return ResponseStatus(message: 'success', hasError: false);
    } else {
      return ResponseStatus(
        message: 'El nickname $id ya esta siendo utilizado',
        hasError: true,
      );
    }
  }
}
