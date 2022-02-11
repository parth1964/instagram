import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? description;
  String? uid;
  String? username;
  String? postId;
  final datePublished;
  String? posturl;
  String? profImage;
  final likes;

  PostModel({
    this.description,
    this.uid,
    this.username,
    this.postId,
    this.datePublished,
    this.posturl,
    this.profImage,
    this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "posturl": posturl,
        "profImage": profImage,
        "likes": likes
      };

  static PostModel fromsnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostModel(
        description: snap['description'],
        uid: snap['uid'],
        username: snap['username'],
        postId: snap['postId'],
        datePublished: snap['datePublished'],
        posturl: snap['posturl'],
        likes: snap['likes'],
        profImage: snap['profImage']);
  }
}
