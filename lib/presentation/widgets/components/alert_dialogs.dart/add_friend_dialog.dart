// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/domain/entities/app_notification.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class AddFriendDialog extends ConsumerStatefulWidget {
  const AddFriendDialog({super.key});

  @override
  AddFriendDialogState createState() => AddFriendDialogState();
}

class AddFriendDialogState extends ConsumerState<AddFriendDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _friendsNickname = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _friendsNickname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add_alt_1_rounded),
          SizedBox(width: 5),
          Text('Añadir amigo'),
        ],
      ),
      actions: [
        CustomFilledButton(
          size: size.width * 0.3,
          text: 'Cancelar',
          color: colors.colorScheme.error,
          height: 35,
          onTap: () {
            context.pop();
          },
        ),
        CustomFilledButton(
          isLoading: isLoading,
          size: size.width * 0.3,
          height: 35,
          text: '+ Añadir',
          onTap: () {
            _addFriend();
          },
        ),
      ],
      content: SizedBox(
        height: 120,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Escribe el nickname de tu amigo:'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: CustomInput(
                      controller: _friendsNickname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa el nickname';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addFriend() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      final notificationRepo = ref.read(notificationRepositoryProvider);
      final responseNotification = await notificationRepo.createNotification(
        notification: AppNotification(
          id: 'no-id',
          type: NotificationType.friend,
          senderId: 'no-senderid',
          receiverId: 'no-id',
          sentAt: Timestamp.fromDate(DateTime.now()),
          status: NotificationStatus.waiting,
          message: '${ref.read(userProvider).name} te ha enviado una solicitud de amistad'
        ),
        nickName: _friendsNickname.text,
      );
      isLoading = false;
      setState(() {});
      showSnackbarResponse(
        context: context,
        response: responseNotification,
      );
      context.pop();
    }
  }
}
