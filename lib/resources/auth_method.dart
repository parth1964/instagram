import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram/resources/firebase_storage.dart';
import 'package:instagram/screens/homescreen.dart';
import 'package:instagram/screens/login_screen.dart';

// import 'package:flutter/material.dart';

class AuthMethods {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  //Signup User
  Future<String> signupUser({
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
    required String username,
  }) async {
    var error;
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null ||
          username.isNotEmpty) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);

        String imageUrl =
            await StorageMethods().uploadImage('Profilepics', file, false);
        print(imageUrl);
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          "email": email,
          "password": password,
          "username": username,
          "bio": bio,
          "followers": [],
          "following": [],
          "image_URL": imageUrl,
        });
        error = "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        error = "The email is Badly Formatted";
      } else if (e.code == 'weak-password') {
        error = "Weak-Password";
      }
    }
    return error;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    var res;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please Enter All the field";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "User is not Available";
      } else if (e.code == "wrong-password") {
        res = "Your Password is wrong";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
