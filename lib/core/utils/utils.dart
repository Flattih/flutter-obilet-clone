import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

void showSnackBar(BuildContext context, String content, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(content),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<File?> pickImage() async {
  try {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      return File(imageFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
//TEMP

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context, "Resim seçilemedi");
    }
  }
  return image;
}

Future<String?> imageUpload(File upload, String path) async {
  File image = File(upload.path);
  Uuid uuid = const Uuid();
  final ref = FirebaseStorage.instance.ref().child(path).child('${uuid.v1()}.jpg');
  await ref.putFile(image);
  final imageUrl = await ref.getDownloadURL();
  return imageUrl;
}
