import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/firebase_storage.dart';
import 'package:instagram/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost({
    required String desc,
    required Uint8List file,
    required String uid,
    required String username,
    required String proImage,
  }) async {
    String res;
    try {
      String photourl = await StorageMethods().uploadImage('posts', file, true);

      String postid = Uuid().v1();

      PostModel postModel = PostModel(
        username: username,
        datePublished: DateTime.now(),
        uid: uid,
        postId: postid,
        description: desc,
        posturl: photourl,
        profImage: proImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postid).set(postModel.toJson());
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likepost(
      {required String postId,
      required String uid,
      required List likes}) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment({
    required String postId,
    required String text,
    required String uid,
    required String name,
    required String profilepic,
  }) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilepic': profilepic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datepiblished': DateTime.now(),
        });
      } else {
        print('Text is Empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletepost(String postId, BuildContext context) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      showsnackBar(e.toString(), context);
    }
  }

  Future<void> followuser(
      {required String uid, required String followId}) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  
}
