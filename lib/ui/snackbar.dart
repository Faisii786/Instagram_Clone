// Function to show a snackbar with the given message
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/utills/colors.dart';

void showSnackbar(String message) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: mobileBackgroundColor,
      content: Center(child: Text(message,style: const TextStyle(color: Colors.red),)),
    ),
  );
}
