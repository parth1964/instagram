import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/reuse_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final textController = TextEditingController();
  final passwordController = TextEditingController();

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
                height: MediaQuery.of(context).size.height / 4,
              ),
              // svg Image
              SvgPicture.asset('assets/images/ic_instagram.svg',
                  color: primaryColor, height: 64),
              SizedBox(height: 30),
              // email textformfield
              const SizedBox(height: 35),
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
              //button
              const SizedBox(height: 35),
              Container(
                child: Text('Log In'),
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
                    child: Text("Dont't have an account?"),
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
