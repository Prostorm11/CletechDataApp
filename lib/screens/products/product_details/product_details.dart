import 'package:cletech/screens/products/product_details/app_header.dart';
import 'package:cletech/screens/products/product_details/data_bundle_card.dart';
import 'package:cletech/screens/products/product_details/models/data_bundle.dart';
import 'package:flutter/material.dart';

class PackagesScreen extends StatefulWidget {
  final String network;
  final List<Map<String, dynamic>> FirebaseBundles;
  const PackagesScreen({
    super.key,
    required this.network,
    required this.FirebaseBundles,
  });

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    // Determine background decoration
    BoxDecoration backgroundDecoration;
    switch (widget.network.toLowerCase()) {
      case "mtn":
        backgroundDecoration = BoxDecoration(
          color: Colors.yellow.withAlpha((0.1 * 255).round()),
        );
        break;
      case "telecel":
        backgroundDecoration = BoxDecoration(
          color: Colors.red.withAlpha((0.1 * 255).round()),
        );
        break;
      case "airteltigo":
        backgroundDecoration = BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withAlpha((0.2 * 255).round()),
              Colors.red.withAlpha((0.2 * 255).round()),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
        break;
      default:
        backgroundDecoration = const BoxDecoration(color: Colors.white);
    }

    // Example bundles for demonstration
     final List<DataBundle> bundles = [];
    for (var item in widget.FirebaseBundles) {
      bundles.add(DataBundle(label: item['name'], dataAmount: item['data_volume'], cost: item['price'].toString(), type: item['validity'], id: item['id'],));
    }

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        child: Column(
          children: [
            AppHeader(
              title: "${widget.network} Data Packages",
              network: widget.network,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: bundles.length,
                itemBuilder: (context, index) {
                  return DataBundleCard(
                    bundle: bundles[index],
                    network: widget.network,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
