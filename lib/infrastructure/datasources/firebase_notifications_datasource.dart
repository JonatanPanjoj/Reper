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

      final notiRef = _database.collection('notifications').doc();

      final resNickname =
          await _userDatasource.validateNickname(nickname: nickName);

      if (!resNickname.hasError) {
        return ResponseStatus(
          message: 'El usuario no existe',
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
          await validateNotification(receiverId: receiverId, senderId: userId);
      if (resValidateNotification.hasError) {
        return resValidateNotification;
      }

      batch.set(
          notiRef,
          notification
              .copyWith(
                id: notiRef.id,
                senderId: userId,
                receiverId: receiverId,
              )
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
  Future<ResponseStatus> validateNotification({
    required String receiverId,
    required String senderId,
  }) async {
    try {
      final snapshot = await _database
          .collection('notifications')
          .where(
            Filter.or(
              Filter.and(
                Filter('receiver_id', isEqualTo: receiverId),
                Filter('sender_id', isEqualTo: senderId),
                Filter("status", isEqualTo: 'waiting'),
                Filter.or(
                  Filter("status", isEqualTo: 'waiting'),
                  Filter("status", isEqualTo: 'accepted'),
                ),
              ),
              Filter.and(
                Filter('receiver_id', isEqualTo: senderId),
                Filter('sender_id', isEqualTo: receiverId),
                Filter.or(
                  Filter("status", isEqualTo: 'waiting'),
                  Filter("status", isEqualTo: 'accepted'),
                ),
              ),
            ),
          )
          .get();
      if (snapshot.docs.isNotEmpty) {
        return ResponseStatus(
          message: 'No puedes enviar solicitud a este usuario',
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

  @override
  Stream<List<AppNotification>> streamUserNotifications() {
    return _database
        .collection('notifications')
        .where('receiver_id', isEqualTo: _auth.currentUser!.uid)
        .where('status', isEqualTo: 'waiting')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppNotification.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<ResponseStatus> changeRequestStatus(
      {required AppNotification notification}) async {
    try {
      final WriteBatch batch = _database.batch();

      final notificationRef =
          _database.collection('notifications').doc(notification.id);
      final receiverRef =
          _database.collection('users').doc(notification.receiverId);
      final senderRef =
          _database.collection('users').doc(notification.senderId);

      batch.set(notificationRef, notification.toJson());

      if (notification.status == NotificationStatus.accepted) {
        batch.update(receiverRef, {
          'friends': FieldValue.arrayUnion([notification.senderId])
        });
        batch.update(senderRef, {
          'friends': FieldValue.arrayUnion([notification.receiverId])
        });
      }
      await batch.commit();

      if (notification.status == NotificationStatus.accepted) {
        return ResponseStatus(message: 'Solicitud aceptada', hasError: false);
      } else {
        return ResponseStatus(message: 'Solicitud rechazada', hasError: false);
      }
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }
}
