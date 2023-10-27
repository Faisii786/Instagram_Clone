import 'package:flutter/material.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("This is Web",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
