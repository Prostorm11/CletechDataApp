import 'package:cletech/screens/products/product_details/models/data_bundle.dart';
import 'package:flutter/material.dart';

class DataBundleCard extends StatelessWidget {
  final DataBundle bundle;
  final String network;

  const DataBundleCard({super.key, required this.bundle, required this.network});

  @override
  Widget build(BuildContext context) {
    // Determine colors based on network
    final Color backgroundColor = network == 'MTN'
        ? Colors.yellow.shade50
        : network == 'Telecel'
            ? Colors.red.shade50
            : Colors.purple.shade50; // AirtelTigo

    final Color borderColor = network == 'MTN'
        ? Colors.yellow.shade700
        : network == 'Telecel'
            ? Colors.red.shade700
            : Colors.purple.shade700; // AirtelTigo

    final Color labelColor = borderColor; // keep the label consistent

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()), // new opacity method
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  bundle.label,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                bundle.type.toUpperCase(),
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Data & Cost Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("Data",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(bundle.dataAmount,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  const Text("Cost",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(bundle.cost,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
