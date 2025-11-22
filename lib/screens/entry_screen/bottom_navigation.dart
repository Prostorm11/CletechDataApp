import 'package:cletech/screens/aboutUs/about.dart';
import 'package:cletech/screens/orders/orders.dart';
import 'package:cletech/screens/products/products.dart';
import 'package:cletech/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainEntryScreen extends StatefulWidget {
  const MainEntryScreen({super.key});

  @override
  State<MainEntryScreen> createState() => _MainEntryScreenState();
}

class _MainEntryScreenState extends State<MainEntryScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  int currentPageIndex = 0;

  List<Widget> pages = [
    Center(child: ProductsScreen()),
    Center(child: OrdersScreen()),
    Center(child: ProfileScreen()),
    Center(child: AboutScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[currentPageIndex]),
      bottomNavigationBar: NavigationBar(
        
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
          currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.shop_outlined),
            label: 'Products',
            selectedIcon: Icon(Icons.shop),
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            label: 'Orders',
            selectedIcon: Icon(Icons.list),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
            selectedIcon: Icon(Icons.person),
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outlined),
            label: 'About Us',
            selectedIcon: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
