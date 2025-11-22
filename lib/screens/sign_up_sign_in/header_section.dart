// _header_section.dart

import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Icons Row (Using colors defined in the main file, if passed, or using defaults)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.wifi, color: Colors.greenAccent, size: 30),
            SizedBox(width: 20),
            Icon(Icons.smartphone, color: Colors.white, size: 30),
            SizedBox(width: 20),
            Icon(Icons.language, color: Colors.white, size: 30),
          ],
        ),
        const SizedBox(height: 10),
        // ConnectHub Title
        const Text(
          'ConnectHub',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        // Subtitle
        Text(
          'Your Gateway to Unlimited Data',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}