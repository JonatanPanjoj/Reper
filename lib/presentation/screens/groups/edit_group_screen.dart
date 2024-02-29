import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reper/config/utils/image_utils.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/widgets/elements/custom_input.dart';

class EditGroupScreen extends ConsumerStatefulWidget {
  final Group group;
  const EditGroupScreen({super.key, required this.group});

  @override
  EditGroupState createState() => EditGroupState();
}

class EditGroupState extends ConsumerState<EditGroupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameGroupController = TextEditingController();
  Uint8List? selectedImage;
  @override
  void initState() {
    _nameGroupController.text = widget.group.name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Grupo'),
        actions: [
          TextButton(
            onPressed: () {
              _updateGroup();
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
              const SizedBox(height: 15,),
              _buildNameInput(),
              const SizedBox(height: 20),
              const Text('Elegir Imagen:', textAlign: TextAlign.start,),
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
      controller: _nameGroupController,
      label: 'Nombre del Grupo:',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nombra a tu grupo';
        }
        return null;
      },
    );
  }

  Widget _buildImagePicker() {
    final colors = Theme.of(context);
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      color: colors.colorScheme.onPrimary,
      strokeWidth: 2,
      dashPattern: [5, 5],
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
    );
  }

  void _updateGroup() async {
    
  }
}
