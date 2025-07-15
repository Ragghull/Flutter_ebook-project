import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookApiService {
  // 🔍 Fetch books by title (for search screen)
  static Future<List<Book>> fetchBooksByTitle(String title) async {
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=intitle:$title&maxResults=20');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'] ?? [];
      return items
          .map<Book>((i) => Book.fromJson(i as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load books by title');
    }
  }

  // 📚 Fetch books by genre (for category scroll in home)
  static Future<List<Book>> fetchBooksByGenre(String genre) async {
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$genre&maxResults=20');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'] ?? [];
      return items
          .map<Book>((i) => Book.fromJson(i as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load books by genre');
    }
  }
}
