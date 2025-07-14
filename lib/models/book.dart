class Book {
  final String title;
  final String thumbnail;
  final String description;

  Book({
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'No Title',
      thumbnail: json['volumeInfo']['imageLinks']?['thumbnail'] ?? '',
      description: json['volumeInfo']['description'] ?? 'No description available',
    );
  }
}
