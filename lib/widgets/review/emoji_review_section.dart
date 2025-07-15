import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmojiReviewSection extends StatefulWidget {
  final String bookId; // Book ID required to fetch and store reviews

  const EmojiReviewSection({super.key, required this.bookId});

  @override
  State<EmojiReviewSection> createState() => _EmojiReviewSectionState();
}

class _EmojiReviewSectionState extends State<EmojiReviewSection> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _emojis = ["😍", "🤔", "😐"];
  String? _selectedEmoji;
  bool _isSubmitting = false;

  void _submitReview() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to submit a review.")),
      );
      return;
    }

    final comment = _commentController.text.trim();

    if (_selectedEmoji == null || comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select an emoji and enter a comment.")),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await FirebaseFirestore.instance.collection("reviews").add({
        "userId": user.uid,
        "userEmail": user.email ?? "Anonymous",
        "bookId": widget.bookId,
        "emoji": _selectedEmoji,
        "comment": comment,
        "timestamp": Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review submitted successfully!")),
      );

      // Clear input
      setState(() {
        _selectedEmoji = null;
        _commentController.clear();
      });
    } catch (e) {
      print("Error submitting review: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error submitting review.")),
      );
    }

    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    final reviewStream = FirebaseFirestore.instance
        .collection("reviews")
        .where("bookId", isEqualTo: widget.bookId)
        .orderBy("timestamp", descending: true)
        .snapshots();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Reaction",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'InstrumentSerif',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Emoji selector
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _emojis.map((emoji) {
            final isSelected = _selectedEmoji == emoji;
            return GestureDetector(
              onTap: () => setState(() => _selectedEmoji = emoji),
              child: AnimatedScale(
                scale: isSelected ? 1.4 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        // Comment box
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            hintText: "Write a one-liner comment...",
            hintStyle: const TextStyle(fontFamily: 'InstrumentSerif'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),

        const SizedBox(height: 10),

        // Submit button
        Center(
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF8AEAE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: _isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
              "Submit",
              style: TextStyle(
                fontFamily: 'InstrumentSerif',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Recent Reactions",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'InstrumentSerif',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // 🔁 Firestore stream builder for live reviews
        StreamBuilder<QuerySnapshot>(
          stream: reviewStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data?.docs ?? [];

            if (docs.isEmpty) {
              return const Text(
                "No reviews yet. Be the first!",
                style: TextStyle(fontFamily: 'InstrumentSerif'),
              );
            }

            return Column(
              children: docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["emoji"] ?? "🤍",
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "${data["userEmail"]?.split('@')[0] ?? "User"}: ${data["comment"]}",
                          style: const TextStyle(
                            fontFamily: 'InstrumentSerif',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
