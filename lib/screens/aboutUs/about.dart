import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: const Center(
        child: Text(
          "This is the About Us Screen",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}