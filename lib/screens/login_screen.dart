import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_vari.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/reuse_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isLoading = false;

  void loginuser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: textController.text, password: passwordController.text);

    if (res != "success") {
      showsnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    } else {
      Get.offAll(
        () => const ResponsiveLayout(
          mobilescreenlayout: MobileScreenLayout(),
          webscreenLayout: WebScreenLayout(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreensize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2.5)
              : EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                // svg Image
                SvgPicture.asset('assets/images/ic_instagram.svg',
                    color: primaryColor, height: 64),
                const SizedBox(height: 30),
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
                InkWell(
                  onTap: loginuser,
                  child: Container(
                    child: _isLoading == false
                        ? Text('Log In')
                        : CircularProgressIndicator(
                            color: primaryColor,
                          ),
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
                      child: Text("Dont't have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(SignupSceen());
                      },
                      child: InkWell(
                        child: Container(
                          child: const Text(
                            " Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: blueColor),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
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
