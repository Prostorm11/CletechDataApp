/* import 'package:cletech/screens/orders/models/data_package.dart';
import 'package:cletech/screens/orders/order_stats_card.dart';
import 'package:cletech/screens/orders/orders_header.dart';
import 'package:cletech/screens/orders/package_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? orders;
  const OrdersScreen({super.key, this.orders});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late int successfulOrders;
  void _handleMenuSelection(BuildContext context, String value) {
    if (value == "clear") {
      // TODO: Clear data logic
      print("Clear All Data");
    } else if (value == "filter") {
      // TODO: Filter logic
      print("Filter");
    }
  }


  @override
  Widget build(BuildContext context) {
   
    print('Orders passed to OrdersScreen: ${widget.orders}');
    final List<DataPackage> readOrders = [];
    if (widget.orders != null) {
      for (var item in widget.orders!) {
        readOrders.add(
          DataPackage(
            title: '${item['bundle']} GB data bundle',
            code: 'code',
            amountPaid: item['amount'].toDouble(),
            status: item['delivered'] == false && item['status'] == 'success'
                ? PackageStatus.inProgress
                : item['status'] == 'initialized'
                ? PackageStatus.failed
                : PackageStatus.delivered,
            time: (item['createdAt'] as Timestamp).toDate(),
          ),
        );
      }
    }
    successfulOrders = readOrders
        .where((order) => order.status == PackageStatus.delivered)
        .length;

    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFE1F5FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── TOP MENU ───────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) =>
                          _handleMenuSelection(context, value),
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "clear",
                          child: Text("Clear All Data"),
                        ),
                        PopupMenuItem(value: "filter", child: Text("Filter")),
                      ],
                    ),
                  ],
                ),

                // ─── HEADER ─────────────────────────────────
                const OrdersHeader(name: "Derrick Marfo"),
                const SizedBox(height: 24),

                // ─── STATS CARD ────────────────────────────
                OrderStatsCard(totalOrders: readOrders.length, successfulOrders: 0),
                const SizedBox(height: 24),

                // ─── PACKAGE DETAILS TITLE ─────────────────
                Text(
                  "Package Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // ─── SCROLLABLE PACKAGE LIST ───────────────
                Expanded(
                  child: ListView.builder(
                    itemCount: readOrders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PackageItem(dataPackage: readOrders[index]),
                      );
                    },
                  ),
                ),

                // ─── FIXED BUY MORE BUTTON ────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Buy More Packages",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */

import 'package:cletech/screens/orders/models/data_package.dart';
import 'package:cletech/screens/orders/order_stats_card.dart';
import 'package:cletech/screens/orders/orders_header.dart';
import 'package:cletech/screens/orders/package_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  final String email; // user email for lazy loading

  const OrdersScreen({super.key, required this.email});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  final int _limit = 10;
  DocumentSnapshot? _lastDoc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchOrders();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch initial or next page of orders
  Future<void> _fetchOrders({bool isRefresh = false}) async {
    if (_isLoadingMore || !_hasMore && !isRefresh) return;

    if (isRefresh) {
      _lastDoc = null;
      _hasMore = true;
    }

    setState(() {
      if (isRefresh) {
        _isLoading = true;
      } else {
        _isLoadingMore = true;
      }
    });

    try {
      Query query = FirebaseFirestore.instance
          .collection('payments')
          .where('email', isEqualTo: widget.email)
          .orderBy('createdAt', descending: true)
          .limit(_limit);

      if (_lastDoc != null) {
        query = query.startAfterDocument(_lastDoc!);
      }

      final querySnapshot = await query.get();

      if (!mounted) return;

      if (isRefresh) _orders.clear();

      final fetchedOrders = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      if (querySnapshot.docs.isNotEmpty) {
        _lastDoc = querySnapshot.docs.last;
      }

      if (fetchedOrders.length < _limit) _hasMore = false;

      setState(() {
        _orders.addAll(fetchedOrders);
        _isLoading = false;
        _isLoadingMore = false;
      });
    } catch (e) {
      print('Error fetching orders: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _fetchOrders();
    }
  }

  void _handleMenuSelection(BuildContext context, String value) {
    if (value == "clear") {
      _fetchOrders(isRefresh: true); // refresh orders
    } else if (value == "filter") {
      print("Filter");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DataPackage> readOrders = [];
    if (_orders.isNotEmpty) {
      for (var item in _orders) {
        readOrders.add(
          DataPackage(
            title: '${item['bundle']} GB data bundle',
            code: 'code',
            amountPaid: (item['amount'] as num).toDouble(),
            status: item['delivered'] == false && item['status'] == 'success'
                ? PackageStatus.inProgress
                : item['status'] == 'initialized'
                ? PackageStatus.failed
                : PackageStatus.delivered,
            time: (item['createdAt'] as Timestamp).toDate(),
          ),
        );
      }
    }

    final successfulOrders = readOrders
        .where((order) => order.status == PackageStatus.delivered)
        .length;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => _fetchOrders(isRefresh: true),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFF9C4), Color(0xFFE1F5FE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ─── TOP MENU ───────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Refresh button
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              tooltip: 'Refresh Orders',
                              onPressed: () => _fetchOrders(isRefresh: true),
                            ),

                            // Existing popup menu
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) =>
                                  _handleMenuSelection(context, value),
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: "clear",
                                  child: Text("Clear All Data"),
                                ),
                                PopupMenuItem(
                                  value: "filter",
                                  child: Text("Filter"),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // ─── HEADER ─────────────────────────────────
                        const OrdersHeader(name: "Derrick Marfo"),
                        const SizedBox(height: 24),

                        // ─── STATS CARD ────────────────────────────
                        OrderStatsCard(
                          totalOrders: readOrders.length,
                          successfulOrders: successfulOrders,
                        ),
                        const SizedBox(height: 24),

                        // ─── PACKAGE DETAILS TITLE ─────────────────
                        const Text(
                          "Package Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ─── SCROLLABLE PACKAGE LIST ───────────────
                        Expanded(
                          child: _orders.isEmpty && !_isLoading
                              ? const Center(
                                  child: Text(
                                    "No orders found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount:
                                      readOrders.length +
                                      (_isLoadingMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index < readOrders.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: PackageItem(
                                          dataPackage: readOrders[index],
                                        ),
                                      );
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                        ),

                        // ─── FIXED BUY MORE BUTTON ────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade700,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Buy More Packages",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
