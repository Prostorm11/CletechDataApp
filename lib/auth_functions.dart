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

Future<Map<String, dynamic>?> getUserDetails(String uid) async {
  try {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('Customers').doc(uid).get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      print("User document not found");
      return null;
    }
  } catch (e) {
    print("Error getting user details: $e");
    return null;
  }
}
Future<List<Map<String, dynamic>>> getUserOrders(String uid) async {
  try {
    // 1. Get user document to obtain email
    final userDoc = await FirebaseFirestore.instance
        .collection('Customers')
        .doc(uid)
        .get();

    if (!userDoc.exists) {
      print("User not found");
      return [];
    }

    final String email = userDoc['email'];

    // 2. Query payment collection by email + status == success
    final querySnapshot = await FirebaseFirestore.instance
        .collection('payments')
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'success')
        .orderBy('createdAt', descending: true)
        .get();

    // 3. Map only the fields you want
    List<Map<String, dynamic>> orders = querySnapshot.docs.map((doc) {
      final data = doc.data();

      return {
        'amount': data['amount'],
        'bundle': data['bundle'],
        'customer_phone': data['customer_phone'],
        'delivered': data['delivered'],
        'createdAt': data['createdAt'],
      };
    }).toList();

    return orders;
  } catch (e) {
    print("Error fetching user orders: $e");
    return [];
  }
}

Future<Map<String, dynamic>?> getPackageById(String docId) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection('Packages')
        .doc(docId)
        .get();

    if (doc.exists) {
      return doc.data();  
    } else {
      print("Package not found");
      return null;
    }
  } catch (e) {
    print("Error fetching package: $e");
    return null;
  }
}

