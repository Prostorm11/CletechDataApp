import 'package:cletech/screens/products/product_details/product_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceTilesGrid extends StatelessWidget {
  final List<Map<String, dynamic>> telecelBundles;
  final List<Map<String, dynamic>> mtnBundles;
  final List<Map<String, dynamic>> airtelTigoBundles;

  const ServiceTilesGrid({
    super.key,
    required this.telecelBundles,
    required this.mtnBundles,
    required this.airtelTigoBundles,
  });

  // Data for the tiles
  final List<Map<String, dynamic>> tiles = const [
    {
      'label': 'Buy MTN data',
      'imagePath': 'assets/images/Mtn.jpg',
      'color': Colors.yellow,
    },
    {
      'label': 'Buy Telecel data',
      'imagePath': 'assets/images/telecel.png',
      'color': Colors.red,
    },
    {
      'label': 'Buy AirtelTigo data',
      'imagePath': 'assets/images/airtelTigo.png',
      'color': Colors.redAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Column(
          children: [
            // Top row: 2 tiles (MTN & Telecel)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: tiles.sublist(0, 2).map((tile) {
                return _buildServiceTile(
                  context,
                  label: tile['label'] as String,
                  color: tile['color'] as Color,
                  imagePath: tile['imagePath'] as String,
                  width: (width / 2) - 24,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Bottom row: 1 centered tile (AirtelTigo)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServiceTile(
                  context,
                  label: tiles[2]['label'] as String,
                  color: tiles[2]['color'] as Color,
                  imagePath: tiles[2]['imagePath'] as String,
                  width: (width / 2) - 24,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildServiceTile(
    BuildContext context, {
    required String label,
    required Color color,
    required String imagePath,
    required double width,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: false).push(
          Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoPageRoute(
                  builder: (_) => PackagesScreen(
                    network: label.toLowerCase().contains("mtn")
                        ? "MTN"
                        : label.toLowerCase().contains("telecel")
                            ? "Telecel"
                            : "AirtelTigo",
                    FirebaseBundles: label.toLowerCase().contains("mtn")
                        ? mtnBundles
                        : label.toLowerCase().contains("telecel")
                            ? telecelBundles
                            : airtelTigoBundles,
                  ),
                )
              : MaterialPageRoute(
                  builder: (_) => PackagesScreen(
                    network: label.toLowerCase().contains("mtn")
                        ? "MTN"
                        : label.toLowerCase().contains("telecel")
                            ? "Telecel"
                            : "AirtelTigo",
                    FirebaseBundles: label.toLowerCase().contains("mtn")
                        ? mtnBundles
                        : label.toLowerCase().contains("telecel")
                            ? telecelBundles
                            : airtelTigoBundles,
                  ),
                ),  
      
        );
      },
        child: Container(
          width: width,
          height: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // Apply gradient only for AirtelTigo, else solid color
            gradient: label == "Buy AirtelTigo data"
                ? const LinearGradient(
                    colors: [Colors.purple, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: label != "Buy AirtelTigo data" ? color : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular image container
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha((0.3 * 255).round()),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: ClipOval(
                    child: Image.asset(imagePath, fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Label
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
