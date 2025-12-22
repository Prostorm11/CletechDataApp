import 'package:cletech/auth_functions.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userInfo;


  const ProfileScreen({super.key, required this.userInfo});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _regionController;
  late final TextEditingController _momoController;
  bool statsLoaded = false;
  late int totalOrders;
  late double totalSpent;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userInfo['name'] ?? '');
    _emailController = TextEditingController(text: widget.userInfo['email'] ?? '');
    _phoneController = TextEditingController(text: widget.userInfo['phone'] ?? '');
    _regionController = TextEditingController(text: widget.userInfo['region'] ?? '');
    _momoController = TextEditingController(text: widget.userInfo['momo'] ?? '');
    getStats();
  }
   Future<void> getStats() async{
    int totalOrderst=0;
    double totalSpentt=0.0;
    final orders=await getOrders( widget.userInfo['email'] ?? '');
    
    final successOrders = orders
    .where((order) =>
        (order['status'] ?? '').toString().toLowerCase() == 'success')
    .toList();

    
    for(var order in successOrders){
      totalSpentt+=order['amount']??0;
      totalOrderst+=1;
    }
    setState(() {
      totalOrders = totalOrderst;
      totalSpent = totalSpentt;
      statsLoaded = true;
    });
   }
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _regionController.dispose();
    _momoController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() => _saving = true);

    try {
      await updateUserProfile({
        "name": _nameController.text.trim(),
        "phone": _phoneController.text.trim(),
        "region": _regionController.text.trim(),
        "momo": _momoController.text.trim(),
      });

     ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    backgroundColor: Colors.white,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    duration: const Duration(seconds: 2),
    content: Row(
      children: const [
        Icon(Icons.check_circle, color: Colors.green, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            "Profile updated successfully!",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  ),
);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    backgroundColor: Colors.white,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    duration: const Duration(seconds: 2),
    content: Row(
      children:  [
        Icon(Icons.check_circle, color: Colors.green, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            "Profile update failed: $e",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  ),
);

    }

    setState(() => _saving = false);
  }

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
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              const SizedBox(height: 24),

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

              // REMOVE CHANGE PASSWORD → Just delete the card

              const SizedBox(height: 20),

              _buildCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(title: "Total Orders", value: statsLoaded ? "$totalOrders" : "--"),
                    
                    _StatItem(title: "Total Spent", value: statsLoaded ? "₵$totalSpent" : "--"),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // --- SAVE CHANGES BUTTON ---
              ElevatedButton.icon(
                onPressed: _saving ? null : _saveChanges,
                icon: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  _saving ? "Saving..." : "Save Changes",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

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
                      borderRadius: BorderRadius.circular(16),
                    ),
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

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
