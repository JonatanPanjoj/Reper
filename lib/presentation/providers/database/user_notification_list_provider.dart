import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/repositories/notification_repository_impl.dart';
import 'package:reper/presentation/providers/providers.dart';

final userNotificationListProvider =
    StateNotifierProvider<NotificationListNotifier, List<AppNotification>>(
  (ref) {
    final notificationsProvider = ref.watch(notificationRepositoryProvider);
    return NotificationListNotifier(notificationsProvider: notificationsProvider);
  }
);

class NotificationListNotifier extends StateNotifier<List<AppNotification>> {
  final NotificationRespositoryImpl notificationsProvider;
  NotificationListNotifier({required this.notificationsProvider}) : super([]);

  streamUserNotifications() {
    notificationsProvider.streamUserNotifications().listen((notificationsList) {

      state = notificationsList;
    });
  }
}
