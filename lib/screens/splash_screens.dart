import 'package:flutter/material.dart';
import 'package:flutter_notification/screens/login_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget
{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//delay for 2 seconds

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds, then go to login screen
    Future.delayed(const Duration(seconds: 2), () {
      // Replace this with your next screen when it's ready
      Navigator.pushReplacement(
        context,
        //smooth transition to navigate to next screen
        MaterialPageRoute(builder: (context) => const LoginScreen()),

      );
    });
  }

  // ui design
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient
          (colors: [
            Color(0xFFFFFDFD),
          Color(0xFFF9D1AD),
          Color(0xFF650E14),
          Color(0xFF110F0F),
        ],begin: Alignment.topLeft,
          end: Alignment.bottomRight,

        )
      ),
      child: const Center(child: Text("TurnOver" ,
        style: TextStyle(fontFamily: "InstrumentSerif",fontSize: 38,color: Colors.black ,
            fontWeight: FontWeight.bold,letterSpacing: 1.5,),
      ),
      ),
    )
    );
  }
}