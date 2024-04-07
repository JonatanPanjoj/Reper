
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
      await database
          .collection('users')
          .doc(uid)
          .set(user.copyWith(uid: uid).toJson());
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
        .where('name', isEqualTo: nickname)
        .get();
    if (snapshot.docs.isEmpty) {
      return ResponseStatus(message: 'success', hasError: false);
    } else {
      final userId = AppUser.fromJson(snapshot.docs.first.data());
      return ResponseStatus(
        message: 'El nickname $nickname ya esta siendo utilizado',
        hasError: true,
        extra: {'user': userId},
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

  @override
  Future<AppUser?> getUserById({required String uid}) async {
    final snapshot = await database.collection('users').doc(uid).get();
    return snapshot.data() == null
        ? null
        : AppUser.fromJson(snapshot.data()!..addAll({'uid': snapshot.id}));
  }

  @override
  Future<ResponseStatus> updateUser({
    required AppUser user,
  }) async {
    try {
      final users = await database
          .collection('users')
          .where('name', isEqualTo: user.name)
          .get();
      if (users.docs.isNotEmpty) {
        for (var usuario in users.docs) {
          if (usuario.id != user.uid) {
            return ResponseStatus(
              message: 'El usuario ya está siendo utilizado por otro usuario',
              hasError: true,
            ); // El ya está siendo utilizado por otro usuario
          }
        }
      }

      await database.collection('users').doc(user.uid).set(user.toJson());

      return ResponseStatus(
        message: 'Se actualizó el usuario con éxito',
        hasError: false,
      );
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> updateGroup(
      {required String uid, required String groupId}) async {
    try {
      await database.collection('users').doc(uid).update({
        'groups': FieldValue.arrayUnion([groupId]),
      });
      return ResponseStatus(message: 'Añadido al grupo', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Stream<AppUser?> streamUser({required String uid}) {
    return database.collection('users').doc(uid).snapshots().map((snapshot) {
      return snapshot.data() == null
          ? null
          : AppUser.fromJson(snapshot.data()!..addAll({'uid': snapshot.id}));
    });
  }

  @override
  Stream<List<AppUser>> streamUserFriends({required List<String> friends}) {
    if (friends.isEmpty) {
      return Stream.value([]);
    }
    return database
        .collection('users')
        .where('uid', whereIn: friends)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => AppUser.fromJson(doc.data())).toList());
  }
}
