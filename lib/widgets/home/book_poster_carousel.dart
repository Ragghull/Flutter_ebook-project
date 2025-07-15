import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../services/book_api_service.dart';
import '../../screens/home/book_detail_screen.dart';

class BookPosterCarousel extends StatefulWidget {
  final String genre;

  const BookPosterCarousel({super.key, required this.genre});

  @override
  State<BookPosterCarousel> createState() => _BookPosterCarouselState();
}

class _BookPosterCarouselState extends State<BookPosterCarousel> {
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  @override
  void didUpdateWidget(covariant BookPosterCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.genre != oldWidget.genre) {
      _fetchBooks();
    }
  }

  Future<void> _fetchBooks() async {
    setState(() => _isLoading = true);
    try {
      final books = await BookApiService.fetchBooksByGenre(widget.genre);

      setState(() {
        _books = books;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching books: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 270,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _books.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final book = _books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookDetailScreen(book: book),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: book.thumbnail,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      book.thumbnail,
                      height: 200,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 130,
                  child: Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'InstrumentSerif',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
