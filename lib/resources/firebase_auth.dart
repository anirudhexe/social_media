import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/resources/storage_methods.dart';
import 'package:social_media/models/user.dart' as model;

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //fetch user data
  Future<model.User> getUserDetails() async {
    // keeping current user pointer in currentuser variable
    User currentUser = _auth.currentUser!;

    //using the above currentuser pointer to fetch the user data
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    //the snapshot is converted into their respective data when we use the fromSnap method which we created in the user model
    return model.User.fromSnap(snap);
  }

  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String result = '';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //add user data to database

        //adding profile photo to storage
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilepics', file, false);

        //here we are calling the user model we created in models which contains the format in which the user data should be structured
        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []);

        //adding user details to database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      }
      return 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = '';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = 'please enter valid email and password';
      }
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'user not found';
      } else if (e.code == 'wrong-password') {
        result = 'wrong password';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
