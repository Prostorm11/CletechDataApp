import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


// Firebase Auth instance
final FirebaseAuth _auth = FirebaseAuth.instance;

// Google Sign-In instance
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

/// Sign in with Google and Firebase
Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger Google Sign-In flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      // User canceled the sign-in
      return null;
    }

    // Obtain authentication details
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create Firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    return await _auth.signInWithCredential(credential);
  } catch (e) {
    print('Google Sign-In failed: $e');
    return null;
  }
}

Future<void> signOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
}

Future<Map<String, dynamic>> fetchAppData(String uid) async {
  try {
    // Fetch user document
    final userFuture = FirebaseFirestore.instance
        .collection('Customers')
        .doc(uid)
        .get();

    // Fetch package document (agent/admin)
    final packageFuture = FirebaseFirestore.instance
        .collection('Packages')
        .doc('HVypJNRxTxdgg9s7LMUzFqsQW8p2')
        .get();

    final userDoc = await userFuture;

    if (!userDoc.exists) {
      print("User not found");
      return {};
    }

   /*  final String email = userDoc['email']; */

    // Fetch user orders
    /* final ordersFuture = FirebaseFirestore.instance
        .collection('payments')
        .where('email', isEqualTo: email)
        
        .orderBy('createdAt', descending: true)
        .get(); */

    final results = await Future.wait([ packageFuture]);
/* 
    final ordersSnapshot = results[0] as QuerySnapshot; */
    final packageDoc = results[0] as DocumentSnapshot;

    /* final orders = ordersSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'amount': data['amount'],
        'bundle': data['bundle'],
        'customer_phone': data['customer_phone'],
        'delivered': data['delivered'],
        'createdAt': data['createdAt'],
        'status': data['status'],
      };
    }).toList(); */

    final packageData = packageDoc.exists ? packageDoc.data() as Map<String, dynamic> : null;

    // Combine all into a single object for app context
    return {
      'user': userDoc.data(),
      'package': packageData,
    };
  } catch (e) {
    print("Error fetching app data: $e");
    return {};
  }
}

Future<void> updateUserProfile(Map<String, dynamic> data) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection("Customers").doc(uid).update(data);
}

Future<List<Map<String, dynamic>>> getOrders(email) async {
   final ordersFuture = FirebaseFirestore.instance
        .collection('payments')
        .where('email', isEqualTo: email)
        
        .orderBy('createdAt', descending: true)
        .get(); 

      var ordersSnapshot=await ordersFuture;
      final orders = ordersSnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'amount': (data['amount'] as num).toDouble(),
        'bundle': data['bundle'],
        'customer_phone': data['customer_phone'],
        'delivered': data['delivered'],
        'createdAt': data['createdAt'],
        'status': data['status'],
      };
    }).toList();

  return orders;
}