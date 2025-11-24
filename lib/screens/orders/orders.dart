import 'package:cletech/screens/orders/models/data_package.dart';
import 'package:cletech/screens/orders/order_stats_card.dart';
import 'package:cletech/screens/orders/orders_header.dart';
import 'package:cletech/screens/orders/package_item.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  void _handleMenuSelection(BuildContext context, String value) {
    if (value == "clear") {
      // TODO: Clear data logic
      print("Clear All Data");
    } else if (value == "filter") {
      // TODO: Filter logic
      print("Filter");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DataPackage> samplePackage = [
      DataPackage(
        title: "5 GB data bundle",
        code: "#5Yro1xBdWKiAh99HdpYC",
        status: PackageStatus.delivered,
        time: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
        amountPaid: 1.00,
      ),
      DataPackage(
        title: "10 GB data bundle",
        code: "#2Yro1xBdWKiAh99HdpYC",
        status: PackageStatus.inProgress,
        time: DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
        amountPaid: 2.00,
      ),
      DataPackage(
        title: "15 GB data bundle",
        code: "#3Yro1xBdWKiAh99HdpYC",
        status: PackageStatus.failed,
        time: DateTime.now().subtract(const Duration(hours: 3, minutes: 45)),
        amountPaid: 3.00,
      ),
      DataPackage(
        title: "15 GB data bundle",
        code: "#3Yro1xBdWKiAh99HdpYC",
        status: PackageStatus.failed,
        time: DateTime.now().subtract(const Duration(hours: 3, minutes: 45)),
        amountPaid: 3.00,
      ),
    ];

    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFE1F5FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── TOP MENU ───────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) =>
                          _handleMenuSelection(context, value),
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "clear",
                          child: Text("Clear All Data"),
                        ),
                        PopupMenuItem(
                          value: "filter",
                          child: Text("Filter"),
                        ),
                      ],
                    ),
                  ],
                ),
            
                // ─── HEADER ─────────────────────────────────
                const OrdersHeader(name: "Derrick Marfo"),
                const SizedBox(height: 24),
            
                // ─── STATS CARD ────────────────────────────
                const OrderStatsCard(totalOrders: 1, successfulOrders: 0),
                const SizedBox(height: 24),
            
                // ─── PACKAGE DETAILS TITLE ─────────────────
                Text(
                  "Package Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
            
                // ─── SCROLLABLE PACKAGE LIST ───────────────
                Expanded(
                  child: ListView.builder(
                    
                    itemCount: samplePackage.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PackageItem(dataPackage: samplePackage[index]),
                      );
                    },
                  ),
                ),
            
                // ─── FIXED BUY MORE BUTTON ────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Buy More Packages",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
