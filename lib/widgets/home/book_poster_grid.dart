import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../services/book_api_service.dart';
import '../../screens/home/book_detail_screen.dart';

class BookPosterGrid extends StatefulWidget {
  final String genre; // 🔥 Genre passed from parent

  const BookPosterGrid({super.key, required this.genre});

  @override
  State<BookPosterGrid> createState() => _BookPosterGridState();
}

class _BookPosterGridState extends State<BookPosterGrid> {
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  @override
  void didUpdateWidget(covariant BookPosterGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.genre != widget.genre) {
      _fetchBooks(); // ⚡ Re-fetch when genre changes
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

    return GridView.builder(
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookDetailScreen(book: _books[index]),
              ),
            );
          },
          child: _HoverZoomCard(book: _books[index]),
        );
      },
    );
  }
}

class _HoverZoomCard extends StatefulWidget {
  final Book book;

  const _HoverZoomCard({required this.book});

  @override
  State<_HoverZoomCard> createState() => _HoverZoomCardState();
}

class _HoverZoomCardState extends State<_HoverZoomCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.05,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.book.thumbnail,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.book.thumbnail,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                widget.book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'InstrumentSerif',
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
