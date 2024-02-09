import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reper/config/utils/utils.dart';

class CustomImagePicker extends StatefulWidget {
  final double height;
  final Function(Uint8List? image)? onPressed;
  const CustomImagePicker({
    super.key,
    this.onPressed,
    this.height = 250,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  Uint8List? selectedImage;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.cardColor,
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
                  if (widget.onPressed != null) {
                    selectedImage = await pickImage(ImageSource.gallery);
                    if (selectedImage == null) return;
                    widget.onPressed!(selectedImage);
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
