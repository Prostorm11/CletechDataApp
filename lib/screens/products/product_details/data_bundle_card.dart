import 'package:cletech/screens/products/product_details/models/data_bundle.dart';
import 'package:flutter/material.dart';

class DataBundleCard extends StatelessWidget {
  final DataBundle bundle;
  final String network;

  const DataBundleCard({
    super.key,
    required this.bundle,
    required this.network,
    
  });

  @override
  Widget build(BuildContext context) {
    // Colors by network
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

    final Color labelColor = borderColor;

    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: labelColor,
                    borderRadius: BorderRadius.circular(8),
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
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            /// Data & Cost Row with icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.storage, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text("Data",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(bundle.dataAmount,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.attach_money, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text("Cost",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(bundle.cost,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
