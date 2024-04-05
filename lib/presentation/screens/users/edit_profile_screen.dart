// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/user_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final AppUser user;

  const EditProfileScreen({super.key, required this.user});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  Uint8List? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    _nameController.text = widget.user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAvatarImage(widget.user),
                CustomInput(
                  controller: _nameController,
                  label: 'Nombre',
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'El nombre no puede estar vacío';
                    }
                    return null;
                  },
                  onChanged:(value) {
                    setState(() {
                      
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:
          _nameController.text != widget.user.name || selectedImage != null
              ? SizedBox(
                  width: size.width * 0.9,
                  child: CustomFilledButton(
                    text: 'Actualizar',
                    isLoading: isLoading,
                    onTap: () {
                      _updateProfile();
                    },
                  ),
                )
              : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAvatarImage(AppUser user) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Stack(
        children: [
          if (selectedImage != null)
            CircleAvatar(
              radius: 62,
              backgroundImage: MemoryImage(selectedImage!),
            )
          else if (user.image.isEmpty)
            CircleAvatar(
              radius: 62,
              child: Text(
                user.name == 'No name' || user.name.isEmpty
                    ? 'KV'
                    : user.name.substring(0, 1),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          else
            CircleAvatar(
              radius: 62,
              backgroundImage: NetworkImage(user.image),
            ),
          _buildAvatarImageIcon(colors),
        ],
      ),
    );
  }

  Widget _buildAvatarImageIcon(ColorScheme colors) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: colors.onSurface,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.edit,
            size: 18,
            color: colors.surface,
          ),
          onPressed: () async {
            final Uint8List? imgPicked = await pickImage(ImageSource.gallery);
            selectedImage = imgPicked;
            if (selectedImage == null) return;
            setState(() {});
          },
        ),
      ),
    );
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      final res = await ref.read(userRepositoryProvider).updateUser(
            user: widget.user.copyWith(
              name: _nameController.text,
            ),
            image: selectedImage,
          );
      isLoading = false;
      setState(() {});
      showSnackbarResponse(context: context, response: res);
      if(!res.hasError){
        context.pop();
      }
    }
  }
}
