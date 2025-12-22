import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsCard extends StatelessWidget {
  final String phoneNumber;

  const ContactUsCard({super.key, required this.phoneNumber});

  /// Opens the phone dialer with the number pre-filled
  void _openDialer(String number) async {
  // Remove spaces, dashes, parentheses
  final sanitizedNumber = number.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  final Uri url = Uri(scheme: 'tel', path: sanitizedNumber);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    debugPrint("Could not open dialer for $sanitizedNumber");
  }
}


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: () => _openDialer(phoneNumber),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Lottie animation
              Lottie.asset(
                "assets/lottie/Contact us!.json",
                width: 80,
                height: 80,
                repeat: true,
              ),
              const SizedBox(width: 16),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      phoneNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // Call icon
              const Icon(Icons.phone, color: Colors.green, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
