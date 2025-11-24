import 'package:flutter/material.dart';

class OrdersHeader extends StatelessWidget {
  final String name;

  const OrdersHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$name's Orders",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.deepPurple.shade700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "Track your data package purchases and payment status",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
        ),
        const SizedBox(height: 16),
        Divider(
          color: Colors.deepPurple.shade100,
          thickness: 1,
        ),
        
      ],
    );
  }
}
