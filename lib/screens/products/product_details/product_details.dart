import 'package:cletech/screens/products/product_details/app_header.dart';
import 'package:cletech/screens/products/product_details/data_bundle_card.dart';
import 'package:cletech/screens/products/product_details/models/data_bundle.dart';
import 'package:flutter/material.dart';


class MtnPackagesScreen extends StatelessWidget {
  final String network;
  const MtnPackagesScreen({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    // Determine background decoration
    BoxDecoration backgroundDecoration;
    switch (network) {
      case "MTN":
        backgroundDecoration = BoxDecoration(
          color: Colors.yellow.withAlpha((0.1 * 255).round()),
        );
        break;
      case "Telecel":
        backgroundDecoration = BoxDecoration(
          color: Colors.red.withAlpha((0.1*255).round()),
        );
        break;
      case "AirtelTigo":
        backgroundDecoration = BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.withAlpha((0.2*255).round()), Colors.red.withAlpha((0.2*255).round())],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
        break;
      default:
        backgroundDecoration = const BoxDecoration(color: Colors.white);
    }

    // Example bundles for demonstration
    final List<DataBundle> bundles = [
      DataBundle(label: "1GB", dataAmount: "1GB", cost: "GHC 4", type: "Regular"),
      DataBundle(label: "2GB", dataAmount: "2GB", cost: "GHC 8", type: "Regular"),
      DataBundle(label: "3GB", dataAmount: "3GB", cost: "GHC 12", type: "Regular"),
    ];

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        child: Column(
          children: [
            AppHeader(title: "$network Data Packages", network: network),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: bundles.length,
                itemBuilder: (context, index) {
                  return DataBundleCard(bundle: bundles[index],network: network,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

