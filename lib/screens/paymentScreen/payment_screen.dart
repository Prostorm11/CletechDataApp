import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'paystack_web_view.dart';

class PaymentScreen extends StatefulWidget {
  final String email;
  final String bundleValue;
  final String bundleId;
  final String customerName;
  final String selectedPackage;

  const PaymentScreen({
    super.key,
    required this.email,
    required this.bundleValue,
    required this.bundleId,
    required this.customerName,
    required this.selectedPackage,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  final String agentId = "HVypJNRxTxdgg9s7LMUzFqsQW8p2";

  Future<void> initiatePayment() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a phone number")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final cleanBundleNumber =
        RegExp(r'\d+').stringMatch(widget.bundleValue) ?? "";

    final body = {
      "email": widget.email,
      "uid": agentId,
      "package_id": widget.bundleId,
      "phone_number": _phoneController.text,
      "full_name": widget.customerName,
      "bundle": cleanBundleNumber,
      "netprovider": widget.selectedPackage.toLowerCase(),
    };

    try {
      final response = await http.post(
        Uri.parse("https://data-buy-server.onrender.com/api/pay"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception("Payment initialization failed");
      }

      final data = jsonDecode(response.body);
      final paymentUrl = data['authorizationUrl'];

      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaystackWebView(url: paymentUrl),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// Content
          SafeArea(
            child: Column(
              children: [
                /// Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Confirm Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        /// Summary Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "You are buying",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.bundleValue,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.selectedPackage.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              const Divider(height: 30),
                              Row(
                                children: [
                                  const Icon(Icons.person_outline),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(widget.customerName),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// Phone Input
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Recipient phone number",
                              icon: Icon(Icons.phone_android),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// Pay Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : initiatePayment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF00C853),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Pay with Paystack",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.lock, size: 16, color: Colors.white70),
                            SizedBox(width: 6),
                            Text(
                              "Secure payment powered by Paystack",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
