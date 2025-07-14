import 'package:flutter/material.dart';
import 'screens/splash_screens.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'widgets/home/top_background.dart';

void main() {
  runApp(const TurnoverApp());
}

class TurnoverApp extends StatelessWidget {
  const TurnoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turnover',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
