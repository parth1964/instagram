import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/reuse_widgets.dart';

class SignupSceen extends StatefulWidget {
  const SignupSceen({Key? key}) : super(key: key);

  @override
  State<SignupSceen> createState() => _SignupSceenState();
}

class _SignupSceenState extends State<SignupSceen> {
  final textController = TextEditingController();

  final passwordController = TextEditingController();

  final bioController = TextEditingController();

  final usernameController = TextEditingController();

  // bool _isLoading = false;

  clearController() {
    textController.clear();
    passwordController.clear();
    bioController.clear();
    usernameController.clear();
  }

  Uint8List? image;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signupUser() async {
    // setState(() {
    //   _isLoading = true;
    // });
    String res = await AuthMethods().signupUser(
        file: image!,
        email: textController.text,
        password: passwordController.text,
        bio: bioController.text,
        username: usernameController.text);
    clearController();

    if (res != "Success") {
      showsnackBar(res, context);
      // setState(() {
      //   _isLoading = false;
      // });
    } else {
      Get.to(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                // svg Image
                SvgPicture.asset('assets/images/ic_instagram.svg',
                    color: primaryColor, height: 64),
                const SizedBox(height: 30),
                // email textformfield
                Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png'),
                          ),
                    Positioned(
                      left: 80,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                ReuseWidgets.textfield(
                    controller: usernameController,
                    hinttext: 'Enter your Username',
                    textinput: TextInputType.emailAddress,
                    obsecure: false,
                    context: context),
                const SizedBox(height: 25),
                ReuseWidgets.textfield(
                    controller: textController,
                    hinttext: 'Enter your Email',
                    textinput: TextInputType.emailAddress,
                    obsecure: false,
                    context: context),
                const SizedBox(height: 25),
                // password textformfield
                ReuseWidgets.textfield(
                    controller: passwordController,
                    hinttext: 'Enter your Password',
                    textinput: TextInputType.emailAddress,
                    obsecure: true,
                    context: context),
                const SizedBox(height: 25),
                ReuseWidgets.textfield(
                    controller: bioController,
                    hinttext: 'Enter your Bio',
                    textinput: TextInputType.emailAddress,
                    obsecure: false,
                    context: context),

                //button
                const SizedBox(height: 35),
                InkWell(
                  onTap: signupUser,
                  child: Container(
                    child: Text('Sign up'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Already Have an account!"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: Container(
                        child: const Text(
                          " Log In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: blueColor),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
