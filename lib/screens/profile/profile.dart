import 'package:cletech/auth_functions.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: "Derrick Marfo");
  final _emailController = TextEditingController(text: "derrick@example.com");
  final _phoneController = TextEditingController(text: "024xxxxxxx");
  final _regionController = TextEditingController(text: "Accra");
  final _momoController = TextEditingController(text: "054xxxxxxx");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER
              const SizedBox(height: 16),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  "Your Profile",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                ),
              ),
              const SizedBox(height: 24),

              // --- USER INFO CARD ---
              _buildCard(
                child: Column(
                  children: [
                    _buildEditableField("Full Name", _nameController),
                    _buildNonEditableField("Email", _emailController),
                    _buildEditableField("Phone Number", _phoneController),
                    _buildEditableField("Region", _regionController),
                    _buildEditableField("MoMo Number", _momoController),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- CHANGE PASSWORD CARD ---
              _buildCard(
                child: ListTile(
                  leading: const Icon(Icons.lock_outline, color: Colors.deepOrange),
                  title: const Text("Change Password"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    // Navigate to change password
                  },
                ),
              ),

              const SizedBox(height: 20),

              // --- ACCOUNT STATS CARD ---
              _buildCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StatItem(title: "Total Orders", value: "12"),
                    _StatItem(title: "Active Bundles", value: "3"),
                    _StatItem(title: "Total Spent", value: "₵45.00"),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // --- LOGOUT BUTTON ---
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await signOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // --- Card helper ---
  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.edit, color: Colors.deepOrangeAccent),
        ),
      ),
    );
  }

  Widget _buildNonEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.lock, color: Colors.grey),
        ),
      ),
    );
  }
}

// --- STAT ITEM ---
class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange)),
        const SizedBox(height: 4),
        Text(title,
            style: TextStyle(
                fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
