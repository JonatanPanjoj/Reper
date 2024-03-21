import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';

class CardNotification extends ConsumerWidget {
  final void Function()? onAccepted;
  final void Function()? onDeclined;

  final AppNotification notification;

  const CardNotification({
    super.key,
    required this.notification,
    this.onAccepted,
    this.onDeclined,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(
                notification.type == NotificationType.friend
                    ? Icons.person_add_alt_1
                    : notification.type == NotificationType.group
                        ? Icons.group
                        : Icons.notifications,
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: size.width * 0.4,
              child: Text(notification.message!),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: onDeclined,
              child: Icon(
                Icons.do_not_disturb,
                color: colors.colorScheme.error,
              ),
            ),
            SizedBox(
              height: 25,
              width: 10,
              child: VerticalDivider(
                color: colors.disabledColor,
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: onAccepted,
              child: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
