import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/reuse_widgets.dart';

class SignupSceen extends StatelessWidget {
  SignupSceen({Key? key}) : super(key: key);

  final textController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
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
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1644181528561-ac0d499a2af0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                  ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_a_photo),
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
              Container(
                child: const Text('Log In'),
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
              const SizedBox(height: 15),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Dont't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  Container(
                    child: const Text(
                      " Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: blueColor),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
