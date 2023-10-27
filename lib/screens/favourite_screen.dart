import 'package:flutter/material.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Icon(
          Icons.favorite,
          size: 50,
          color: Colors.red,
        ),
      ),
    ));
  }
}
