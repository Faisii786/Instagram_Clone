// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:instagram_clone/utills/colors.dart';

class MyButton extends StatelessWidget {
  final String title;
  bool loading = false;
  MyButton({super.key, required this.title, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: blueColor, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: primaryColor,
                )
              : Text(
                  title,
                  style: const TextStyle(fontSize: 25),
                )),
    );
  }
}
