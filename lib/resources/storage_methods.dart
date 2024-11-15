import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childname, Uint8List file, bool isPost) async {
    Reference ref =
        _firebaseStorage.ref().child(childname).child(_auth.currentUser!.uid);

    //ref() is a pointer to the file in the storage and the child() refers to the folder names

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    //after creating a pointer to the file path we're putting the data there
    UploadTask uploadTask = ref.putData(file);
    //with this upload task we have the ability to control how the file is being uploaded to the fb storage

    TaskSnapshot snap = await uploadTask;
    //we can use this snapshot to get the download url of tbe file with which we can display it on screen

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;

    //TODO: Delete image from storage
  }
}
