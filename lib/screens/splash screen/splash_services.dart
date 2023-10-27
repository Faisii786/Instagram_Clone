import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/home%20screens/home_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';

class CheckUserState {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Get.to(() => const HomeScreen());
      });
    } else if(user == null) {
      Timer(const Duration(seconds: 3), () {
        Get.to(() => const LoginScreen());
      });
    }
  }
}
