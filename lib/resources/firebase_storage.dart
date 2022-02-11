import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> uploadImage(
    String childName,
    Uint8List file,
    bool ispost,
  ) async {
    Reference reference =
        storage.ref().child(childName).child(auth.currentUser!.uid);

    if (ispost) {
      String id = const Uuid().v1();
      reference = reference.child(id);
    }

    UploadTask uploadTask = reference.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
