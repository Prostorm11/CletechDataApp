import 'package:cletech/screens/aboutUs/become_agent_card.dart';
import 'package:cletech/screens/aboutUs/contact_us.dart';
import 'package:cletech/screens/aboutUs/whatsapp_group_card.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFE1F5FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(height: 16),
              ContactUsCard(phoneNumber: "+233 123 456 789"),
              SizedBox(height: 24),
              WhatsAppGroupCard(
                  groupLink: "https://chat.whatsapp.com/yourgroupid"),
              SizedBox(height: 24),
              BecomeAgentCard(
                  agentLink: "https://yourwebsite.com/become-agent",
                  
                  ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
