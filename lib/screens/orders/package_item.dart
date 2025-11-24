import 'package:cletech/screens/orders/models/data_package.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PackageItem extends StatelessWidget {
  final DataPackage dataPackage;

  const PackageItem({super.key, required this.dataPackage});

  Color _getStatusColor(PackageStatus status) {
    switch (status) {
      case PackageStatus.delivered:
        return Colors.green;
      case PackageStatus.inProgress:
        return Colors.orange;
      case PackageStatus.failed:
        return Colors.red;
    }
  }

  String _getStatusText(PackageStatus status) {
    switch (status) {
      case PackageStatus.delivered:
        return "Delivered";
      case PackageStatus.inProgress:
        return "In Progress";
      case PackageStatus.failed:
        return "Failed";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(dataPackage.status);
    final statusText = _getStatusText(dataPackage.status);

    final formattedTime =
        DateFormat("MMM d, h:mm a").format(dataPackage.time);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 2),
            color: Colors.black.withAlpha((0.05 * 255).round()),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE — DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  dataPackage.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                // Code
                Text(
                  dataPackage.code,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 10),

                // STATUS + TIME
                Row(
                  children: [
                    // Status chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha((0.12 * 255).round()),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: statusColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Time
                    Text(
                      formattedTime,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // RIGHT SIDE — AMOUNT
          Text(
            "₵${dataPackage.amountPaid.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
