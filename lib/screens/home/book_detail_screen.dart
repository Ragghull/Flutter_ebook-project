import 'package:flutter/material.dart';
import '../../models/book.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(book.title, style: TextStyle(fontFamily: 'InstrumentSerif')),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: book.thumbnail,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  book.thumbnail,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              book.description ?? "No description available.",
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'InstrumentSerif',
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _ActionButton(icon: Icons.thumb_up, label: "Like"),
                _ActionButton(icon: Icons.menu_book, label: "Review"),
                _ActionButton(icon: Icons.check_circle_outline, label: "Finished"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Color(0xFF650E14)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'InstrumentSerif',
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
