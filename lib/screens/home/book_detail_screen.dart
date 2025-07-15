import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../widgets/home/top_background.dart';
import '../../widgets/review/emoji_review_section.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TopBackground(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
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
                    const SizedBox(height: 16),

                    Text(
                      '${book.author ?? 'Unknown Author'}'
                          '${book.publishedDate != null ? ', ${book.publishedDate}' : ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'InstrumentSerif',
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //  Pass bookId to EmojiReviewSection
                    EmojiReviewSection(bookId: book.id),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
