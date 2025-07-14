import 'package:flutter/material.dart';
import 'package:flutter_notification/screens/home/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordHidden = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFDFD),
              Color(0xFFF9D1AD),
              Color(0xFF650E14),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🎬 Lottie Animation
              Center(
                child: Lottie.asset(
                  'assets/animations/main_scene.json',
                  height: 200,
                  repeat: true,
                  animate: true,
                ),
              ),
              const SizedBox(height: 20),

              //  Heading
              Text(
                'Hey Reader',
                style: TextStyle(
                  fontFamily: 'InstrumentSerif',
                  fontSize: 28,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              //  Email Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'InstrumentSerif',
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //  Password Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordHidden,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'InstrumentSerif',
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              //  Login Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    String password = _passwordController.text.trim();
                    String email = _emailController.text;
                    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text('Please enter a valid email'),
                    backgroundColor: Colors.red.shade300,
                    ),
                    ); }
                    else if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                      Text('Password cannot be empty'),backgroundColor: Colors.red.shade300,),);
                    } else if (password.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                      Text('Password should be atleast 6 characters'),backgroundColor: Colors.red.shade300,),);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      );
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'InstrumentSerif',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              //  Register Button
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    "New user? Register here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'InstrumentSerif',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
