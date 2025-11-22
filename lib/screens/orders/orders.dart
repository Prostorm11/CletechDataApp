import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: const Center(
        child: Text(
          "This is the Orders Screen",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}