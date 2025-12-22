import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class BecomeAgentCard extends StatefulWidget {
  final String agentLink;

  const BecomeAgentCard({
    super.key,
    required this.agentLink,
  });

  @override
  State<BecomeAgentCard> createState() => _BecomeAgentCardState();
}

class _BecomeAgentCardState extends State<BecomeAgentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    // Setup the bouncing animation for the button
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _bounceAnimation = Tween<double>(begin: 0, end: -10)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    _controller.repeat(reverse: true);
  }

  /// Opens the link in the device's default external browser
  Future<void> _openBecomeAgent(String link) async {
    final Uri url = Uri.parse(link);
    
    try {
      // LaunchMode.externalApplication is critical for opening the actual browser app
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint("Could not launch $url");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not open the browser.")),
          );
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Lottie Robot Animation ---
            Lottie.asset(
              "assets/lottie/robot.json", 
              width: 120, 
              height: 120,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 12),

            // --- Text Content ---
            const Text(
              "Join this journey with us",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Make money by becoming an agent selling data bundles.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // --- Bouncy Become Agent Button ---
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: child,
                );
              },
              child: ElevatedButton(
                onPressed: () => _openBecomeAgent(widget.agentLink),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Become an Agent",
                  style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      letterSpacing: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}