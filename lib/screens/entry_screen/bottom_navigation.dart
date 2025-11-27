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
  bool _active = true;

  Map<String, dynamic>? userDetails;
  Map<String, dynamic>? packageData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _active = false;
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final data = await fetchAppData(user!.uid);

      if (!_active || !mounted) return;

      setState(() {
        userDetails = data['user'];
        packageData = Map<String, dynamic>.from(data['package'] ?? {});
        isLoading = false;
      });
    } catch (e) {
      if (!_active || !mounted) return;
      setState(() => isLoading = false);
    }
  }

  int currentPageIndex = 0;

      List<Widget> get pages => [
        _TabNavigator(child: ProductsScreen(packages: packageData ?? {}, userInfo: userDetails ?? {},)),
        _TabNavigator(child: OrdersScreen(email: userDetails?['email'] ?? '')),
        _TabNavigator(child: ProfileScreen(userInfo: userDetails ?? {},)),
        const _TabNavigator(child: AboutScreen()),
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/lottie/Sandy Loading.json',
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF9C4),
              Color(0xFFE1F5FE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: IndexedStack(
            index: currentPageIndex,
            children: pages,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() => currentPageIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shop_outlined),
            selectedIcon: Icon(Icons.shop),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outlined),
            selectedIcon: Icon(Icons.info),
            label: 'About Us',
          ),
        ],
      ),
    );
  }
}

/// --------------------------------
/// NESTED NAVIGATOR (keeps page state)
/// --------------------------------
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
