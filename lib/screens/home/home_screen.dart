import 'package:flutter/material.dart';
import '../../../widgets/home/top_background.dart';
import '../../../widgets/home/search_greeting_section.dart';
import '../../../widgets/home/category_scroll.dart';
import '../../../widgets/home/book_poster_grid.dart';
import '../../../widgets/navigation/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom nav bar
      bottomNavigationBar: const BottomNavBar(),

      body: Stack(
        children: [
          //  Background gradient + image
          const TopBackground(),

          //  Search & Greeting placed over the cloud
          const SearchGreetingSection(),

          //  Scrollable content below the header
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 250, bottom: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  CategoryScroll(),

                  const SizedBox(height: 30),
                  BookPosterGrid(), //  Posters Grid
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
