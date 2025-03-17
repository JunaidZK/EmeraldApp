import 'package:emerald_beauty/api_classes/review/give_review.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:flutter/material.dart';

class AppGiveReviewProvider extends ChangeNotifier {
  GiveReview reviewApi = GiveReview();
  final reviewController = TextEditingController();

  int _rating = 0;

  int get rating => _rating;

  set rating(int newRating) {
    _rating = newRating;
    notifyListeners(); // Notify listeners when the rating changes
  }

  Future<void> giveReview({required int id}) async {
    String message = await reviewApi.sendReview(
        bookingId: id, review: reviewController.text, rating: rating);
    showToast(message);
  }
}
