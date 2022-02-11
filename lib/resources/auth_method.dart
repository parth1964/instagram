import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/resources/firebase_storage.dart';

class AuthMethods {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool isloding = false;

  //Get Username and Other User Details

  Future<UserModel> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromsnap(snapshot);
  }

  // Signup User
  Future<String> signupUser({
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
    required String username,
  }) async {
    var error;
    try {
      if (email != null ||
          password != null ||
          bio != null ||
          file != null ||
          username != null) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);

        String imageUrl =
            await StorageMethods().uploadImage('Profilepics', file, false);
        print(imageUrl);

        UserModel userModel = UserModel(
          username: username,
          email: email,
          uid: FirebaseAuth.instance.currentUser!.uid,
          photourl: imageUrl,
          bio: bio,
          followers: [],
          following: [],
        );
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());

        error = "Success";
      } else {
        error = "Please Enter All Field";
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

  // Future<String> signupUser({
  //   required String email,
  //   required String password,
  //   required String bio,
  //   required Uint8List file,
  //   required String username,
  // }) async {
  //   var error;

  //   if (email != null ||
  //       password != null ||
  //       bio != null ||
  //       file != null ||
  //       username != null) {
  //     try {
  //       UserCredential userCredential = await auth
  //           .createUserWithEmailAndPassword(email: email, password: password);
  //       print(userCredential.user!.uid);

  //       String imageUrl =
  //           await StorageMethods().uploadImage('Profilepics', file, false);
  //       print(imageUrl);

  //       UserModel userModel = UserModel(
  //         username: username,
  //         email: email,
  //         uid: FirebaseAuth.instance.currentUser!.uid,
  //         photourl: imageUrl,
  //         bio: bio,
  //         followers: [],
  //         following: [],
  //       );
  //       await firestore
  //           .collection('users')
  //           .doc(userCredential.user!.uid)
  //           .set(userModel.toJson());

  //       error = "Success";
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == "'") {
  //         error = "User is Not available Please Loggen In";
  //       }
  //     }
  //   } else {
  //     error = "Please Enter All Field";
  //   }
  //   return error;
  // }
  // on FirebaseAuthException catch (e) {
  //   if (e.code == "invalid-email") {
  //     error = "The email is Badly Formatted";
  //   } else if (e.code == 'weak-password') {
  //     error = "Weak-Password";
  //   }
  // }
  // return error;

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    var res;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
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

  Future<void> signout() async {
    await auth.signOut();
  }
}
