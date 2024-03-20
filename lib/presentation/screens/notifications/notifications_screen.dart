import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(userNotificationListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('No tienes notificaciones'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return CardNotification(
                    notification: notifications[index],
                    onAccepted: () {
                      changeStatus(
                        notifications[index]
                            .copyWith(status: NotificationStatus.accepted),
                        ref,
                        context,
                      );
                    },
                    onDeclined: () {
                      changeStatus(
                        notifications[index]
                            .copyWith(status: NotificationStatus.rejected),
                        ref,
                        context,
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  Future<void> changeStatus(
    AppNotification notification,
    WidgetRef ref,
    BuildContext context,
  ) async {
    final res = await ref
        .read(notificationRepositoryProvider)
        .changeRequestStatus(notification: notification);
    // ignore: use_build_context_synchronously
    showSnackbarResponse(context: context, response: res);
  }
}
