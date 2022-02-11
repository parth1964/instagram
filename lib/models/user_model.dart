import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? email;
  String? uid;
  String? photourl;
  String? bio;
  List? followers;
  List? following;

  UserModel(
      {this.username,
      this.email,
      this.uid,
      this.photourl,
      this.bio,
      this.followers,
      this.following});

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "photourl": photourl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static UserModel fromsnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        username: snap['username'],
        email: snap['email'],
        uid: snap['uid'],
        photourl: snap['photourl'],
        bio: snap['bio'],
        followers: snap['followers'],
        following: snap['followers']);
  }
}
