// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reper/config/utils/image_utils.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/widgets/elements/custom_input.dart';
import 'package:reper/presentation/widgets/utils/show_snackbar_response.dart';

class EditRepertoryScreen extends ConsumerStatefulWidget {
  final Repertory repertory;
  const EditRepertoryScreen({super.key, required this.repertory});

  @override
  EditRepertoryState createState() => EditRepertoryState();
}

class EditRepertoryState extends ConsumerState<EditRepertoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _repertoryNameController =
      TextEditingController();
  Uint8List? selectedImage;
  String? repertoryImage;
  bool isLoading = false;

  @override
  void initState() {
    _repertoryNameController.text = widget.repertory.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Repertorio'),
        actions: [
          TextButton(
            onPressed: () {
              _updateRepertory();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [_bodyEdit()],
      ),
    );
  }

  Widget _bodyEdit() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              _buildNameInput(),
              const SizedBox(height: 20),
              const Text(
                'Elegir Imagen:',
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              _buildImagePicker(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    final colors = Theme.of(context);
    return CustomInput(
      fillColor: colors.cardColor,
      controller: _repertoryNameController,
      label: 'Nombre del Repertorio:',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nombra a tu Repertorio';
        }
        return null;
      },
    );
  }

  Widget _buildImagePicker() {
    final colors = Theme.of(context);
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      color: colors.colorScheme.onPrimary,
      strokeWidth: 2,
      dashPattern: const [5, 5],
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
              selectedImage != null
                  ? Image.memory(
                      selectedImage!,
                    )
                  : Image.network(widget.repertory.image),
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
    );
  }

  void _updateRepertory() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      if (selectedImage != null) {
        repertoryImage = await uploadImageToStorage(
            fileName: widget.repertory.id,
            childName: 'repertories',
            mediaFile: selectedImage!);
      }
      final res = await ref.read(repertoryRepositoryProvider).updateRepertory(
            repertory: widget.repertory.copyWith(
              name: _repertoryNameController.text,
            ),
          );
          isLoading = false;
      setState(() {});
      showSnackbarResponse(context: context, response: res);
      
      context.pop();
    }
  }
}
