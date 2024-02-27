// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/group_list_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  CreateGroupScreenState createState() => CreateGroupScreenState();
}

class CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameGroupController = TextEditingController();
  Uint8List? selectedImage;
  bool isLoading = false;

  @override
  void dispose() {
    _nameGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Crea tu Grupo!', style: bold24),
                const SizedBox(height: 10),
                Text(
                  'Aquí puedes comenzar a crear reportorios y visualizarlo junto con tus amigos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.dividerColor,
                  ),
                ),
                const SizedBox(height: 25),
                CustomInput(
                  fillColor: colors.cardColor,
                  controller: _nameGroupController,
                  label: 'Nombre del Grupo:',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nombra a tu grupo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  color: colors.colorScheme.onPrimary,
                  strokeWidth: 2,
                  dashPattern: [5,5],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colors.canvasColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          if (selectedImage != null)
                            Image.memory(
                              selectedImage!,
                            ),
                          Center(
                            child: IconButton(
                              iconSize: 35,
                              icon: const Icon(
                                Icons.image,
                              ),
                              onPressed: () async {
                                selectedImage = await pickImage(ImageSource.gallery);
                                if (selectedImage == null) return;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                CustomFilledButton(
                  text: 'Crea el grupo',
                  isLoading: isLoading,
                  onTap: () {
                    _createGroup();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createGroup() async {
    if (_formKey.currentState!.validate()) {
      if (selectedImage == null) {
        showSnackbarResponse(
          context: context,
          response: ResponseStatus(
            message: 'Selecciona una imagen',
            hasError: true,
          ),
        );
        return;
      }
      isLoading = true;
      setState(() {});
      final res = await ref.read(groupListProvider.notifier).addGroup(
            groupName: _nameGroupController.text,
            mediaFile: selectedImage!,
          );
      isLoading = false;
      setState(() {});
      showSnackbarResponse(
        context: context,
        response: res,
      );
      if (!res.hasError) {
        context.pop();
      }
    }
  }
}
