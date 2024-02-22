// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class AddReperDialog extends ConsumerStatefulWidget {

  final String groupId;

  const AddReperDialog({super.key, required this.groupId});

  @override
  AddReperDialogState createState() => AddReperDialogState();
}

class AddReperDialogState extends ConsumerState<AddReperDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reperNameController = TextEditingController();
  Uint8List? selectedImage;
  bool isLoading = false;

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
          isLoading: isLoading,
          size: size.width * 0.3,
          height: 35,
          text: 'Create',
          onTap: () {
            _createReper();
          },
        ),
      ],
      content: SizedBox(
        height: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInput(
                label: 'Nombre:',
                controller: _reperNameController,
                fillColor: colors.cardColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomImagePicker(
                height: 150,
                onPressed: (image) {
                  selectedImage = image;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createReper() async {
    if (_formKey.currentState!.validate()) {
      if (selectedImage == null) {
        showSnackbarResponse(
          context: context,
          response: ResponseStatus(
            message: 'Seleccione una imagen',
            hasError: true,
          ),
        );
        return;
      }
      isLoading = true;
      setState(() {});
      final res = await ref.read(repertoryRepositoryProvider).createRepertory(
            repertory: Repertory(
              id: 'no-id',
              groupId: widget.groupId,
              name: _reperNameController.text,
              image: 'no-image',
              sections: [],
            ),
            groupId: widget.groupId,
            image: selectedImage!,
          );
      isLoading = false;
      setState(() {});
      showSnackbarResponse(
        context: context,
        response: res,
      );
      context.pop();
    }
  }
}
