import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/firebase_notifications_datasource.dart';
import 'package:reper/infrastructure/repositories/notification_repository_impl.dart';

final notificationRepositoryProvider = Provider((ref) {
  return NotificationRespositoryImpl(FirebaseNotificationsDatasource());
});