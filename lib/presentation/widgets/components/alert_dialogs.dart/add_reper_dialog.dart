import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/presentation/widgets/elements/custom_filled_button.dart';
import 'package:reper/presentation/widgets/elements/custom_input.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class AddReperDialog extends StatefulWidget {
  const AddReperDialog({super.key});

  @override
  State<AddReperDialog> createState() => _AddReperDialogState();
}

class _AddReperDialogState extends State<AddReperDialog> {
  final TextEditingController _reperName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text('Crea un Repertorio'),
      actions: [
        CustomFilledButton(
          size: size.width * 0.3,
          text: 'Cancel',
          color: colors.colorScheme.error,
          height: 35,
          onTap: () {
            context.pop();
          },
        ),
        CustomFilledButton(
          size: size.width * 0.3,
          height: 35,
          text: 'Create',
          onTap: () {
            context.pop();
          },
        ),
      ],
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            CustomInput(
              label: 'Nombre:',
              controller: _reperName,
              fillColor: colors.cardColor,
            ),
          ],
        ),
      ),
    );
  }
}
