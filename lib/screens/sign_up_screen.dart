import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Firebase_Auth/authentication_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/ui/button.dart';
import 'package:instagram_clone/ui/snackbar.dart';
import 'package:instagram_clone/ui/text_field.dart';
import 'package:instagram_clone/utills/image_picker.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // loading on button
  bool loading = false;

  // global key for snackbar
  // GlobalKey<ScaffoldMessengerState> globalkey =
  //     GlobalKey<ScaffoldMessengerState>();

  // text fields controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    bioController.dispose();
  }

  // Pick the image function
  // pickImage function is created on utills file
  Uint8List? profileImage; // this variable is used as ternary ope.
  Future selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      profileImage = img;
    });
  }
  // end

  // user registration

  void userRegistration() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim().toLowerCase();
    String password = passController.text;
    String bio = bioController.text;

    if (name.isEmpty) {
      showSnackbar("Name cannot be empty");
      return;
    } else if (name.contains(RegExp(r'\d'))) {
      showSnackbar("Name cannot contain numbers");
      return;
    } else if (email.isEmpty) {
      showSnackbar("Email cannot be empty");
      return;
    } else if (password.isEmpty) {
      showSnackbar("Password cannot be empty");
      return;
    } else if (password.length < 6) {
      showSnackbar("Password must be at least 6 characters long");
      return;
    } else if (bio.isEmpty) {
      showSnackbar("Bio cannot be empty");
      return;
    } else if (bio.contains(RegExp(r'\d'))) {
      showSnackbar("Bio cannot contain numbers");
      return;
    }

    try {
      setState(() {
        loading = true;
      });
      await AuthMethods().signUpUser(
        name: name,
        email: email,
        password: password,
        bio: bio,
        profilePhoto: profileImage!,
      );

      Get.to(
        () => const LoginScreen(),
        transition: Transition.fade,
        duration: const Duration(seconds: 1),
      );
    } on FirebaseAuthException catch (ex) {
      showSnackbar(ex.toString());
      setState(() {
        loading = false;
      });
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_instagram.svg',
                    color: Colors.white,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      profileImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: MemoryImage(profileImage!),
                            )
                          : const CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage("assets/images/profile.jpg"),
                            ),
                      Positioned(
                          top: 75,
                          left: 70,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo_rounded),
                            color: Colors.grey[700],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(myController: nameController, hintText: 'Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(myController: emailController, hintText: 'Email'),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      myController: passController, hintText: 'Password'),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(myController: bioController, hintText: 'Bio'),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      userRegistration();
                    },
                    child: MyButton(
                      loading: loading,
                      title: 'Register',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const LoginScreen(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 19),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
