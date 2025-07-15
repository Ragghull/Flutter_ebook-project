class Book {
  final String id;
  final String title;
  final String thumbnail;
  final String? author;
  final String? publishedDate;

  Book({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.author,
    this.publishedDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['volumeInfo']['title'] ?? 'No Title',
      thumbnail: json['volumeInfo']['imageLinks']?['thumbnail'] ??
          'https://via.placeholder.com/150',
      author: (json['volumeInfo']['authors'] != null)
          ? (json['volumeInfo']['authors'] as List).join(', ')
          : null,
      publishedDate: json['volumeInfo']['publishedDate'],
    );
  }
}
