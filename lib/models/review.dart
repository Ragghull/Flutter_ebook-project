class Review {
  final String userId;
  final String bookId;
  final List<String> emojiReactions;
  final String oneLiner;
  final DateTime timestamp;

  Review({
    required this.userId,
    required this.bookId,
    required this.emojiReactions,
    required this.oneLiner,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bookId': bookId,
      'emojiReactions': emojiReactions,
      'oneLiner': oneLiner,
      'timestamp': timestamp,
    };
  }
}
