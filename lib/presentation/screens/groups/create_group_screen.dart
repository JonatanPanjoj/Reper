import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameGroupController = TextEditingController();

  MediaFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                controller: _nameGroupController,
                label: 'Nombre del Servidor',
              ),
              const SizedBox(height: 25),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: colors.canvasColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Expanded(
                  child: selectedImage == null
                      ? Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.image,
                            ),
                            onPressed: () async {
                              selectedImage = await pickImage(context);
                              if (selectedImage == null) return;
                              setState(() {});
                            },
                          ),
                        )
                      : ThumbnailMedia(
                          media: selectedImage!,
                        ),
                ),
              ),
              const SizedBox(height: 25),
              const CustomFilledButton(text: 'Crea el grupo'),
            ],
          ),
        ),
      ),
    );
  }
}
