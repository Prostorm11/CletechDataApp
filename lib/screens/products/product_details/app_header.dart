import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String network; // "MTN", "Telecel", "AirtelTigo"
  const AppHeader({super.key, required this.title, required this.network});

  @override
  Widget build(BuildContext context) {
    // Determine gradient or color based on network
    BoxDecoration backgroundDecoration;

    switch (network) {
      case "MTN":
        backgroundDecoration = const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC300), Color(0xFFFFA400)], // MTN yellow gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
        break;
      case "Telecel":
        backgroundDecoration = const BoxDecoration(
          color: Colors.red,
        );
        break;
      case "AirtelTigo":
        backgroundDecoration = const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
        break;
      default:
        backgroundDecoration = const BoxDecoration(
          color: Colors.grey,
        );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: backgroundDecoration,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
