import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

Future<MediaFile?> pickImage(BuildContext context) async {
  final MediaFile? sigleMedia;
  final mediaList =
      await GalleryPicker.pickMedia(context: context, singleMedia: true);

  if (mediaList != null || mediaList!.isNotEmpty) {
    sigleMedia = mediaList.first;
  }else{
    sigleMedia = null;
  }

  return sigleMedia;
}
