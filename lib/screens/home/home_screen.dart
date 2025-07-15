import 'package:flutter/material.dart';
import '../../../widgets/home/top_background.dart';
import '../../../widgets/home/search_greeting_section.dart';
import '../../../widgets/home/category_scroll.dart';
import '../../../widgets/navigation/bottom_nav_bar.dart';
import '../../../widgets/home/book_poster_carousel.dart'; // ✅ Carousel version

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "Fiction"; // 🌟 Default selected genre

  // 🔁 Updates the genre when a category is tapped
  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(), // ⬇ Bottom navigation bar

      body: Stack(
        children: [
          const TopBackground(), // 🎨 Gradient + cloud background
          const SearchGreetingSection(), // 👋 Greeting + search bar

          // 📜 Scrollable content under the header
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 250, bottom: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // 🗂️ Category tabs (Fiction, Romance, etc.)
                  CategoryScroll(
                    onTapCategory: onCategorySelected,
                    selectedCategory: selectedCategory,
                  ),

                  const SizedBox(height: 30),

                  // 🎠 Book posters displayed in swiper/carousel
                  BookPosterCarousel(genre: selectedCategory),

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
