import 'dart:io';

import 'package:cashback/core/providers/firebase_providers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider = Provider(
  (ref) => FirebaseStorageRepository(
    firebaseStorage: ref.read(storageProvider),
  ),
);

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  FirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> uploadFileToFirebaseStorage(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
