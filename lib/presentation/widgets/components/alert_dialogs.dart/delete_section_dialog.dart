// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class DeleteSectionDialog extends ConsumerStatefulWidget {
  const DeleteSectionDialog({super.key});

  @override
  DeleteSectionDialogState createState() => DeleteSectionDialogState();
}

class DeleteSectionDialogState extends ConsumerState<DeleteSectionDialog> {
  Uint8List? selectedImage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        'Eliminar Sección',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFilledButton(
              size: size.width * 0.3,
              text: 'Cancelar',
              color: colors.dividerColor,
              height: 35,
              onTap: () {
                context.pop(false);
              },
            ),
            const SizedBox(width: 10),
            CustomFilledButton(
              isLoading: isLoading,
              size: size.width * 0.3,
              height: 35,
              color: colors.colorScheme.error,
              text: 'Eliminar',
              onTap: () {
                context.pop(true);
              },
            ),
          ],
        ),
      ],
      content: const SizedBox(
        height: 50,
        child: Column(
          children: [
            Text(
              '¿Estas seguro que quieres eliminar la sección?',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
