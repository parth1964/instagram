import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/search_screen.dart';

import '../screens/profile_screen.dart';

const webScreensize = 600;

var homescreenItem = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(child: Text('Favorite')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
