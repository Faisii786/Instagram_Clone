import 'package:flutter/material.dart';
import 'package:instagram_clone/utills/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;

  const MyTextField(
      {super.key, required this.myController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        filled: true,
        hintStyle: const TextStyle(color: greyColor, fontSize: 20),
        hintText: hintText,

        //border: InputBorder.none,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          //borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
