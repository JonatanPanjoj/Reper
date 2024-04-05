import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(userNotificationListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notifications.isEmpty
          ? _buildEmptyNotifications()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return CardNotification(
                    notification: notifications[index],
                    onAccepted: () {
                      changeStatus(
                        notifications[index].copyWith(
                          status: NotificationStatus.accepted,
                        ),
                        ref,
                        context,
                      );
                    },
                    onDeclined: () {
                      changeStatus(
                        notifications[index].copyWith(
                          status: NotificationStatus.rejected,
                        ),
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

  Widget _buildEmptyNotifications() {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/sad-rippy.png',
            height: size.width *0.7,
            width: size.width *0.7,
          ),
          const SizedBox(height: 25),
          const Text('No tienes notificaciones', style: bold20,),
        ],
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
