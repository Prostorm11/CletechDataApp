import 'dart:math';

import 'package:cletech/screens/products/become_agent_card.dart';
import 'package:cletech/screens/products/service_tiles_grid.dart';
import 'package:cletech/screens/products/welcome_card.dart';
import 'package:cletech/screens/products/quick_package_card.dart'; // new import
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ProductsScreen extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  final Map<String, dynamic>? packages;
  const ProductsScreen({super.key, this.userInfo, this.packages});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    // Sample top 3 quick packages
    final List<Map<String, String>> quickPackages = [];
   if (widget.packages != null) {
  final mtnPackages = widget.packages!['mtn'];

  if (mtnPackages is List && mtnPackages.isNotEmpty) {
    for (int i = 0; i < 3; i++) {
      final topPackage = mtnPackages[Random().nextInt(mtnPackages.length)];

      quickPackages.add({
        "network": "MTN",
        "data": topPackage['dataVolume'] ?? 'N/A',
        "price": topPackage['price']?.toString() ?? 'N/A',
        "validity": topPackage['validity'] ?? 'N/A',
      });
    }
  }
}



    return Scaffold(
      body: Stack(
        children: [
          // --- Background Gradient ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF9C4), Color(0xFFE1F5FE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // --- Scrollable Content ---
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),

                // --- Animated Title ---
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * -30),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFF59D), Color(0xFFFFF176)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.1 * 255).round()),
                          blurRadius: 6,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
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
                        pause: const Duration(seconds: 10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32.0),

                // --- Welcome Card ---
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * 20),
                        child: child,
                      ),
                    );
                  },
                  child: WelcomeCard(
                    userName:
                        widget.userInfo != null &&
                            widget.userInfo!['name'] != null
                        ? widget.userInfo!['name']
                        : 'User',
                  ),
                ),

                const SizedBox(height: 24),

                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) =>
                      Opacity(opacity: value, child: child),
                  child: BecomeAgentCard(
                    onTap: () {
                      // Navigate to become agent page
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // --- Quick Packages ---
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quick Packages",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: quickPackages.map((pkg) {
                        return QuickPackageCard(
                          networkName: pkg["network"]!,
                          dataAmount: pkg["data"]!,
                          price: pkg["price"]!,
                          validity: pkg["validity"]!,
                          onTap: () {
                            // TODO: Buy this package instantly
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // --- Service Tiles Grid ---
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * 30),
                        child: child,
                      ),
                    );
                  },
                  child: ServiceTilesGrid(
                    telecelBundles:
                        widget.packages != null &&
                            widget.packages!['telecel'] != null
                        ? List<Map<String, dynamic>>.from(
                            widget.packages!['telecel'],
                          )
                        : [],
                    mtnBundles:
                        widget.packages != null &&
                            widget.packages!['mtn'] != null
                        ? List<Map<String, dynamic>>.from(
                            widget.packages!['mtn'],
                          )
                        : [],
                    airtelTigoBundles:
                        widget.packages != null &&
                            widget.packages!['airteltigo'] != null
                        ? List<Map<String, dynamic>>.from(
                            widget.packages!['airteltigo'],
                          )
                        : [],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
