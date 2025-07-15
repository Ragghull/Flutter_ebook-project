// lib/screens/search/search_screen.dart
import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../services/book_api_service.dart';
import '../home/book_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Book> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchBooks() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final results = await BookApiService.fetchBooksByTitle(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      print("Search error: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFDFD), Color(0xFFF9D1AD), Color(0xFF650E14)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  onSubmitted: (_) => _searchBooks(),
                  decoration: InputDecoration(
                    hintText: 'Search for books...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchBooks,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isLoading) const CircularProgressIndicator(),
                if (!_isLoading && _searchResults.isEmpty && _controller.text.isNotEmpty)
                  const Text("No books found."),
                if (_searchResults.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final book = _searchResults[index];
                        return ListTile(
                          leading: Image.network(book.thumbnail, width: 50, fit: BoxFit.cover),
                          title: Text(book.title),
                          subtitle: Text(book.author ?? 'Unknown'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookDetailScreen(book: book),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
