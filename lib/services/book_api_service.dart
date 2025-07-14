import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookApiService {
  static Future<List<Book>> fetchBooks() async {
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:fiction&maxResults=20'
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'] ?? [];
      return items
          .map<Book>((i) => Book.fromJson(i as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
