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
