import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BecomeAgentCard extends StatefulWidget {
  final String agentLink;

  const BecomeAgentCard({super.key, this.agentLink = ""});

  @override
  State<BecomeAgentCard> createState() => _BecomeAgentCardState();
}

class _BecomeAgentCardState extends State<BecomeAgentCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _jumpAnimation;

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
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _jumpAnimation = Tween<double>(begin: 1.0, end: 1.05)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    // Repeat the animation up and down
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Pause a bit before next jump
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) _controller.forward();
        });
      }
    });

    // Start initial animation after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _jumpAnimation,
      child: GestureDetector(
        onTap: () => _openBecomeAgent(widget.agentLink),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF176), Color(0xFFFFEE58)],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Become an Agent",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.ads_click, size: 32, color: Colors.deepOrangeAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
