import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Firebase_Auth/authentication_methods.dart';
import 'package:instagram_clone/screens/home%20screens/home_screen.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/ui/button.dart';
import 'package:instagram_clone/ui/snackbar.dart';
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
  Future loginUser() async {
    String email = emailController.text.trim().toLowerCase();
    String password = passController.text;

    if (email.isEmpty) {
      showSnackbar("Email cannot be empty");
      return;
    } else if (password.isEmpty) {
      showSnackbar("Password cannot be empty");
      return;
    } else if (password.length < 6) {
      showSnackbar("Password must be at least 6 characters long");
      return;
    }

    try {
      setState(() {
        loading = true;
      });
      User? user =
          await AuthMethods().userlogin(email: email, password: password);

      if (user != null) {
        Get.to(
          () => const HomeScreen(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
      } else {
        showSnackbar("An error occurred. Please check your credentials.");
        setState(() {
          loading = false;
        });
      }
    } on FirebaseAuthException catch (ex) {
      showSnackbar(ex.toString());
      setState(() {
        loading = false;
      });

      showSnackbar(ex.toString());
    } catch (e) {
      showSnackbar("An error occurred: $e");
      setState(() {
        loading = false;
      });
    }

    setState(() {
      loading = false;
    });
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
