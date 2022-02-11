import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
   UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
