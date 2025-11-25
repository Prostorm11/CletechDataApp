import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String network; // "MTN", "Telecel", "AirtelTigo"
  const AppHeader({super.key, required this.title, required this.network});

  @override
  Widget build(BuildContext context) {
    // Determine gradient or color based on network
    Gradient backgroundGradient;
    switch (network) {
      case "MTN":
        backgroundGradient = const LinearGradient(
          colors: [Color(0xFFFFC300), Color(0xFFFFA400)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        break;
      case "Telecel":
        backgroundGradient = const LinearGradient(
          colors: [Color(0xFFFF5C5C), Color(0xFFFF1F1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        break;
      case "AirtelTigo":
        backgroundGradient = const LinearGradient(
          colors: [Colors.purple, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        break;
      default:
        backgroundGradient = const LinearGradient(
          colors: [Colors.grey, Colors.black26],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
