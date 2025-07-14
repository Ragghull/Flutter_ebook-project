import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchGreetingSection extends StatelessWidget {
  const SearchGreetingSection({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon ';
    return 'Good Evening ';
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Search &  Profile Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.search, color: Colors.black38, size: 28),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 🌞 Greeting
          Text(
            _getGreeting(),
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'InstrumentSerif',
            ),
          ),
          const SizedBox(height: 10),

          // 💬 Quote
          const Text(
            '"A reader lives a thousand lives before he dies."',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontFamily: 'InstrumentSerif',
            ),
          ),
        ],
      ),
    );
  }
}
