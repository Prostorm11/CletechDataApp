import 'package:cletech/screens/products/service_tiles_grid.dart';
import 'package:cletech/screens/products/welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center title
          children: <Widget>[
            // --- Animated Styled Title ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Cletech Bundles',
                      speed: const Duration(milliseconds: 150),
                      cursor: '|',
                    ),
                  ],
                  repeatForever: true,
                  pause: const Duration(seconds: 10), // Pause before looping
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // --- Welcome Card ---
            const WelcomeCard(userName: 'Derrick Marfo'),

            const SizedBox(height: 24.0),

            // --- Service Tiles Grid ---
            const ServiceTilesGrid(),
          ],
        ),
      ),
    );
  }
}
