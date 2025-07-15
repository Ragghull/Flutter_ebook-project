import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';

class ReviewService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> submitReview(Review review) async {
    await _firestore.collection('reviews').add(review.toMap());
  }
}
