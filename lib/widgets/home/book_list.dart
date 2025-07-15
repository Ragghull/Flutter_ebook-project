import 'package:flutter/material.dart';
import '../../services/book_api_service.dart';
import '../../models/book.dart';

class BookList extends StatefulWidget {
  final String titleQuery;

  const BookList({super.key, required this.titleQuery});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late Future<List<Book>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = BookApiService.fetchBooksByTitle(widget.titleQuery);
  }

  @override
  void didUpdateWidget(covariant BookList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.titleQuery != widget.titleQuery) {
      booksFuture = BookApiService.fetchBooksByTitle(widget.titleQuery);
      setState(() {}); // Trigger rebuild
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final books = snapshot.data!;
        return SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        book.thumbnail,
                        height: 180,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'InstrumentSerif',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
