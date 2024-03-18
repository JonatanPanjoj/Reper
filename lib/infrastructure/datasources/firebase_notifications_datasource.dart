import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reper/domain/datasources/notification_datasource.dart';
import 'package:reper/domain/entities/app_notification.dart';
import 'package:reper/domain/entities/app_user.dart';
import 'package:reper/domain/entities/shared/response_status.dart';
import 'package:reper/infrastructure/datasources/firebase_user_datasource.dart';

class FirebaseNotificationsDatasource extends NotificationDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseUserDatasource _userDatasource = FirebaseUserDatasource();

  @override
  Future<ResponseStatus> getNotification({
    required String receiverId,
  }) async {
    try {
      return ResponseStatus(
          message: 'Notificaciones Obtenidas', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> createNotification(
      {required AppNotification notification, required String nickName}) async {
    try {
      final userId = _auth.currentUser!.uid;
      final WriteBatch batch = _database.batch();

      final notiRef = _database.collection('notification').doc();

      final resNickname =
          await _userDatasource.validateNickname(nickname: nickName);

      if (!resNickname.hasError) {
        return ResponseStatus(
          message: 'Usuario inexistente :c',
          hasError: true,
        );
      }

      final receiverId = (resNickname.extra!['user'] as AppUser).uid;

      if (receiverId == userId) {
        return ResponseStatus(
          message: 'No tienes más amigos? 🤔',
          hasError: true,
        );
      }

      final resValidateNotification =
          await validateNotification(receiverId: receiverId);
      if (resValidateNotification.hasError) {
        return resValidateNotification;
      }

      batch.set(
          notiRef,
          notification
              .copyWith(
                  id: notiRef.id, senderId: userId, receiverId: receiverId)
              .toJson());

      await batch.commit();

      return ResponseStatus(
          message: 'Se envió notificación a $nickName', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> validateNotification(
      {required String receiverId}) async {
    try {
      final snapshot = await _database
          .collection('notification')
          .where('receiverId', isEqualTo: receiverId)
          .where('status', isEqualTo: 'waiting')
          .where('status', isEqualTo: 'accepted')
          .get();
      if (snapshot.docs.isNotEmpty) {
        return ResponseStatus(
          message: 'Lo sentimos, has mandado suficientes notificaciones :c',
          hasError: true,
        );
      }
      return ResponseStatus(message: 'No hay notificaciones', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }
}
