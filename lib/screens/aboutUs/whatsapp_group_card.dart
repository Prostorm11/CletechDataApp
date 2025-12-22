import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppGroupCard extends StatelessWidget {
  final String groupLink;

  const WhatsAppGroupCard({super.key, required this.groupLink});

  void _openWhatsapp(String link) async {
    final Uri url = Uri.parse(link);
    
    try {
      // mode: LaunchMode.externalApplication is key for deep-linking into apps
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url, 
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint("Could not launch $url");
      }
    } catch (e) {
      debugPrint("Error launching WhatsApp: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: () => _openWhatsapp(groupLink),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Lottie.asset(
                "assets/lottie/Social Media Influencer.json",
                width: 80,
                height: 80,
                repeat: true,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Join Our WhatsApp Group",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Stay updated, chat with community",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chat, color: Colors.green, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
