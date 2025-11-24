import 'package:flutter/material.dart';

class OrderStatsCard extends StatelessWidget {
  final int totalOrders;
  final int successfulOrders;

  const OrderStatsCard({
    super.key,
    required this.totalOrders,
    required this.successfulOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatBox(
          "Total Orders",
          totalOrders.toString(),
          icon: Icons.receipt_long,
          bgColor: Colors.blue.shade50,
          iconColor: Colors.blue,
        ),
        const SizedBox(width: 12),
        _buildStatBox(
          "Successful",
          successfulOrders.toString(),
          icon: Icons.check_circle_outline,
          bgColor: Colors.green.shade50,
          iconColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildStatBox(String label, String value,
      {required IconData icon, required Color bgColor, required Color iconColor}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                color: iconColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
