
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class PackagesTestScreen extends StatefulWidget {
  @override
  _PackagesTestScreenState createState() => _PackagesTestScreenState();
}

class _PackagesTestScreenState extends State<PackagesTestScreen> {
  int? packagesCount;
  String? error;
  Map<String, dynamic>? packageData;

  @override
  void initState() {
    super.initState();
    _fetchPackageById();
  }

  Future<void> _fetchPackageById() async {
  const documentId = 'HVypJNRxTxdgg9s7LMUzFqsQW8p2'; // the specific document ID
  try {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Packages')
        .doc(documentId)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      setState(() {
        packageData = data;
      });
      print('Package data: $data');
      setState(() {
        packagesCount = 1; // only one document fetched
      });
    } else {
      print('No package found with ID $documentId');
      setState(() {
        packagesCount = 0;
      });
    }
  } catch (e) {
    setState(() {
      error = e.toString();
    });
    print('Error fetching package: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Packages Test')),
      body: Center(
        child: packagesCount != null
            ? Text('Packages count: $packagesCount data: $packageData')
            : error != null
                ? Text('Error: $error')
                : CircularProgressIndicator(),
      ),
    );
  }
}
