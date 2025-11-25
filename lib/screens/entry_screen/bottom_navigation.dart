/* import 'package:cletech/screens/aboutUs/about.dart';
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
 */

import 'package:cletech/auth_functions.dart';
import 'package:cletech/screens/aboutUs/about.dart';
import 'package:cletech/screens/orders/orders.dart';
import 'package:cletech/screens/products/products.dart';
import 'package:cletech/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class MainEntryScreen extends StatefulWidget {
  const MainEntryScreen({super.key});

  @override
  State<MainEntryScreen> createState() => _MainEntryScreenState();
}

class _MainEntryScreenState extends State<MainEntryScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
   Map<String, dynamic>? userDetails;
   List<Map<String, dynamic>>? orders;
   Map<String, dynamic>? packageData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await fetchAppData(user!.uid);
    setState(() {
      userDetails = data['user'];
      orders = data['orders'];
      packageData = data['package'];
      isLoading = false;
    });
  }

  int currentPageIndex = 0;

  /*  final List<Widget> pages =  [
    _TabNavigator(child: ProductsScreen(
      packages: packageData,
    )),
    _TabNavigator(child: OrdersScreen()),
    _TabNavigator(child: ProfileScreen()),
    _TabNavigator(child: AboutScreen()),
  ]; */
  List<Widget> get pages => [
    _TabNavigator(child: ProductsScreen(packages: packageData)),
    const _TabNavigator(child: OrdersScreen()),
    const _TabNavigator(child: ProfileScreen()),
    const _TabNavigator(child: AboutScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
    return  Scaffold(
      body: Center(child: Lottie.asset( 'assets/lottie/Sandy Loading.json',)),
    );
  }
  print('Package Data: $packageData');
    return Scaffold(
      body: Container(
        // Consistent background for all screens
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF9C4),
              Color(0xFFE1F5FE),
            ], // light pastel gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: IndexedStack(index: currentPageIndex, children: pages),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
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

/// -------------------------
/// NESTED NAVIGATOR WIDGET
/// -------------------------
class _TabNavigator extends StatelessWidget {
  final Widget child;

  const _TabNavigator({required this.child});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child),
    );
  }
}
