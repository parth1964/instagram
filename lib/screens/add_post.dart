import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final posttextController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  void postImag({
    required String uid,
    required String username,
    required String profImage,
  }) async {
    try {
      setState(() {
        _isloading = true;
      });
      String res = await FirestoreMethods().uploadPost(
          desc: posttextController.text,
          file: _image!,
          uid: uid,
          username: username,
          proImage: profImage);

      if (res == "Success") {
        setState(() {
          _isloading = false;
        });
        showsnackBar("Posted", context);
      } else {
        _isloading = false;
        showsnackBar(res, context);
      }
    } catch (e) {
      showsnackBar(e.toString(), context);
    }
  }

  selectImage() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create a Post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _image = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Choose From Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _image = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return _image == null
        ? Center(
            child: IconButton(
              onPressed: () {
                selectImage();
                print(userModel.photourl);
              },
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back), onPressed: () {}),
              title: const Text('Post to'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                    onPressed: () {
                      postImag(
                        uid: userModel.uid!,
                        username: userModel.username!,
                        profImage: userModel.photourl!,
                      );
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          color: Colors.blueAccent, 
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ), 
                  ),
                )
              ],
            ),
            body: _isloading
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userModel.photourl!),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextField(
                                controller: posttextController,
                                decoration: const InputDecoration(
                                    hintText: 'Write a Caption',
                                    border: InputBorder.none),
                                maxLines: 8,
                              ),
                            ),
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: AspectRatio(
                                aspectRatio: 487 / 451,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: MemoryImage(_image!),
                                      fit: BoxFit.fill,
                                      alignment: FractionalOffset.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Divider(),
                      ],
                    ),
                  ),
          );
  }
}
