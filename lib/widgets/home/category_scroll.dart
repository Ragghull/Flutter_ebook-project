import 'package:flutter/material.dart';

class CategoryScroll extends StatelessWidget {
  final List<String> categories = [
    "Fiction", "Comics", "Education", "Romance", "Sci-Fi", "History", "Business"
  ];

  CategoryScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6), // Less rounded
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              categories[index],
              style: const TextStyle(
                fontFamily: 'InstrumentSerif',
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }
}
