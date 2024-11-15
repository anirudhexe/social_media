import 'package:flutter/material.dart';
import 'package:social_media/resources/firebase_auth.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = const User(
    bio: 'null',
    email: 'null',
    photoUrl: 'null',
    uid: 'null',
    username: 'null',
    followers: [],
    following: [],
  );
  final AuthProvider _authProvider = AuthProvider();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authProvider.getUserDetails();
    _user = user;
    notifyListeners(); //this will notify all the parts of the app, that the data for user has changed so, it will update the app accordingly
  }
}
