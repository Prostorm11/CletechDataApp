// _main_content_card.dart

import 'package:cletech/auth_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


const Color _localPrimaryColor = Color(0xFF5E35B1);

class MainContentCard extends StatelessWidget {
  const MainContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              // Welcome Text
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _localPrimaryColor,
                ),
              ),
              // ... other static texts ...
              const SizedBox(height: 20),
              _buildGoogleButton(),
              const SizedBox(height: 30),

              // Feature Cards Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  _FeatureCard(icon: Icons.smartphone, label: 'Mobile Data'),
                  _FeatureCard(icon: Icons.public, label: 'Broadband'),
                  _FeatureCard(icon: Icons.flash_on, label: '5G Speed'),
                ],
              ),
              const SizedBox(height: 30),
              
              Text(
                'Secure authentication • Instant access to packages',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildGoogleButton() {
    return ElevatedButton.icon(
       onPressed: () async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential != null) {
      
      print('User signed in: ${userCredential.user?.displayName}');
   
    } else {
      
      print('Sign-in canceled or failed');
    }
  },
     icon: Image.asset(
        'assets/images/google.png',
        height: 24,
        width: 24,
      ),
      label: const Text(
        'Continue with Google',
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        elevation: 1,
      ),
    );
  }
}

// Inner Feature Card Widget
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 75,
                height: 75,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon, color: _localPrimaryColor, size: 30),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: _localPrimaryColor),
          ),
        ],
      ),
    );
  }
}