// _special_banner.dart

import 'package:flutter/material.dart';

class SpecialBanner extends StatelessWidget {
  const SpecialBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        decoration: BoxDecoration(
          // Use a custom gradient for the banner
          gradient: const LinearGradient(
            colors: [Color(0xFF00BFA5), Color(0xFF18FFFF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: const <Widget>[
            Icon(Icons.card_giftcard, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Special: Get 20% extra data on first purchase',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}