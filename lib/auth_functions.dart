import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// Firebase Auth instance
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Google Sign-In instance
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

// Supabase instance
final supabase = Supabase.instance.client;

/// Sign in with Google and Firebase
Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger Google Sign-In flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // User canceled sign-in

    // Obtain authentication details
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create Firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) return null;

    // Prepare customer data
    final customerData = {
      'createdAt': FieldValue.serverTimestamp(), // timestamp when document is first created
      'updatedAt': FieldValue.serverTimestamp(), // timestamp to update each login
      'email': user.email,
      'name': user.displayName,
      'photoURL': user.photoURL,
      'uid': user.uid,
    };

    // Save or update in Firestore under Customers collection with uid as doc id
    await _firestore.collection('Customers').doc(user.uid).set(
      customerData,
      SetOptions(merge: true), // merge: true to update existing doc if already present
    );

    return userCredential;
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
    // 1️⃣ Fetch user data
    final userData = await supabase
        .from('customers')
        .select()
        .eq('uid', uid)
        .maybeSingle();

    // 2️⃣ Fetch all admin packages
    final packagesList = await supabase
        .from('admin_packages')
        .select()
        .eq('active', true); // optional filter for active packages

    // 3️⃣ Ensure the result is a list of maps
    final List<Map<String, dynamic>> packages = List<Map<String, dynamic>>.from(packagesList);

    // 4️⃣ Group by provider/network
    final Map<String, List<Map<String, dynamic>>> groupedPackages = {};
    for (var pkg in packages) {
      final network = pkg['provider']?.toString().toLowerCase() ?? 'unknown';
      groupedPackages.putIfAbsent(network, () => []);
      groupedPackages[network]!.add(pkg);
    }

    return {
      'user': userData ?? {},
      'package': groupedPackages,
    };
  } catch (e) {
    print("Error fetching app data: $e");
    return {
      'user': {},
      'package': {},
    };
  }
}





Future<void> updateUserProfile(Map<String, dynamic> data) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection("Customers").doc(uid).update(data);
}

Future<List<Map<String, dynamic>>> getOrders(String email) async {
  final response = await supabase
      .from('payments')
      .select()
      .eq('email', email)
      .order('created_at', ascending: false);

  return response.map<Map<String, dynamic>>((data) {
    return {
      'amount': (data['amount'] as num).toDouble(),
      'bundle': data['bundle'],
      'customer_phone': data['customer_phone'],
      'delivered': data['delivered'],
      'createdAt': data['created_at'], // renamed for app consistency
      'status': data['status'],
    };
  }).toList();
}
