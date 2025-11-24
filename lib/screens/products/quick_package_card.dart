import 'package:flutter/material.dart';

class QuickPackageCard extends StatelessWidget {
  final String networkName;
  final String dataAmount;
  final String price;
  final String validity;
  final VoidCallback? onTap;

  const QuickPackageCard({
    super.key,
    required this.networkName,
    required this.dataAmount,
    required this.price,
    required this.validity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              networkName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.deepOrangeAccent),
            ),
            const SizedBox(height: 6),
            Text(
              dataAmount,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              price,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                  fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              validity,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
