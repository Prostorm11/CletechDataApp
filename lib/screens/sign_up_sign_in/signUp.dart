import 'package:cletech/screens/sign_up_sign_in/header_section.dart';
import 'package:cletech/screens/sign_up_sign_in/main_content_card.dart';
import 'package:cletech/screens/sign_up_sign_in/special_banner.dart';
import 'package:flutter/material.dart';

// --- Color and Style Definitions ---
const Color primaryColor = Color(0xFF5E35B1);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFFDD835);

const LinearGradient mainGradient = LinearGradient(
  colors: [
    primaryColor,
    secondaryColor,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // 1. Gradient Background and Floating Dots
            Container(
              decoration: const BoxDecoration(
                gradient: mainGradient,
              ),
            ),
            Positioned(
                top: 100,
                left: 30,
                child: _buildDot(20.0, Colors.white.withOpacity(0.3))),
            Positioned(
                top: 200,
                right: 10,
                child: _buildDot(10.0, accentColor.withOpacity(0.5))),
        
            // 2. Scrollable Content
            SafeArea(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Center(child: HeaderSection()),
                  const SizedBox(height: 30),
                  MainContentCard(), // removed const
                  const SizedBox(height: 20),
                  SpecialBanner(),   // removed const
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
