import 'package:cletech/firebase_options.dart';
import 'package:cletech/screens/entry_screen/bottom_navigation.dart';
import 'package:cletech/screens/sign_up_sign_in/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:AuthWrapper()
    );
  }
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SafeArea(child: Center(child: CircularProgressIndicator())),
          );
        }

        // Error state
        if (snapshot.hasError) {
          return const Scaffold(
            body: SafeArea(child: Center(child: Text("Something went wrong!"))),
          );
        }

        // Decide screen (remove const!)
        if (snapshot.hasData) {
          return MainEntryScreen();
        }

        return SignUpScreen();
      },
    );
  }
}