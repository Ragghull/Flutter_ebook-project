import 'package:flutter/material.dart';

class CategoryScroll extends StatelessWidget {
  final List<String> categories = [
    "Fiction", "Comics", "Education", "Romance", "Sci-Fi", "History", "Business"
  ];

  final String selectedCategory;
  final Function(String) onTapCategory;

  CategoryScroll({
    super.key,
    required this.selectedCategory,
    required this.onTapCategory,
  });

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
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onTapCategory(category), // 🔁 Notify parent
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF650E14) : Colors.white,
                borderRadius: BorderRadius.circular(6),
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
                category,
                style: TextStyle(
                  fontFamily: 'InstrumentSerif',
                  fontSize: 15,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
