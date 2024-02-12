import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

Future<dynamic> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  final XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
}

Future<String> uploadImageToStorage({
  required String fileName,
  required String childName,
  required Uint8List mediaFile,
}) async {

  final Reference ref = _storage.ref().child(childName).child(fileName);

  final UploadTask uploadTask = ref.putData(
    mediaFile,
    SettableMetadata(contentType: 'image/png'),
  );

  final TaskSnapshot snap = await uploadTask;

  final String downloadUrl = await snap.ref.getDownloadURL();

  return downloadUrl;
}

Future<void> deleteImageFromStorage({
  required String fileName,
  required String childName,
}) async {
  final Reference ref = FirebaseStorage.instance
      .ref()
      .child(childName)
      .child(fileName);

  await ref.delete();
}
