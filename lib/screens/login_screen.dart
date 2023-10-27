import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Firebase_Auth/authentication_methods.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/ui/button.dart';
import 'package:instagram_clone/ui/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // for button loading
  bool loading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  // method for login
  void loginUser() {
    setState(() {
      loading = true;
    });
    AuthMethods()
        .userlogin(email: emailController.text, password: passController.text);
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: Colors.white,
                height: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(myController: emailController, hintText: 'Email'),
              const SizedBox(
                height: 10,
              ),
              MyTextField(myController: passController, hintText: 'Password'),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  loginUser();
                },
                child: MyButton(
                  loading: loading,
                  title: 'LOGIN',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have and account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const SignInScreen(),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 1));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 19),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
