
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/openpage.dart';
import 'package:taxi_app/verification.dart';
import 'phoneauth.dart'; // Ensure this import points to your PhoneAuth file

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Pin (verificationId: '',),
    );
  }
}



