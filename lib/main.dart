import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screens.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Optional: Save launch info to SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasLaunched', true); // just example

  runApp(const TurnoverApp());
}

class TurnoverApp extends StatelessWidget {
  const TurnoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turnover',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // We’ll add internet check here next
    );
  }
}
