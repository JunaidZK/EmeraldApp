import 'package:emerald_beauty/api_classes/profile/ratings_reviews/ratings_reviews.dart';
import 'package:emerald_beauty/model_class/profile/ratings_reviews/ratings_and_reviews.dart';
import 'package:flutter/material.dart';

class ReceivedRatingsProvider extends ChangeNotifier {
  ReviewResponse? review;
  RatingsReviewsApi reviewsApi = RatingsReviewsApi();

  double overallRating = 0.0;
  int totalReviews = 0;
  Map<int, int> ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  Map<int, double> ratingPercentages = {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0, 5: 0.0};

  ReceivedRatingsProvider() {
    getAllReviews();
  }

  Future<void> getAllReviews() async {
    review = await reviewsApi.fetchReviews();
    if (review != null) {
      calculateReviewStats();
    }
    notifyListeners();
  }

  void calculateReviewStats() {
    if (review == null) return;

    totalReviews = review!.data.reviews.length;

    // Reset counts and percentages
    ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    overallRating = 0.0;

    // Count ratings
    for (var r in review!.data.reviews) {
      ratingCounts[r.rating] = (ratingCounts[r.rating] ?? 0) + 1;
    }

    // Calculate overall rating and percentages
    for (int rating = 1; rating <= 5; rating++) {
      int count = ratingCounts[rating] ?? 0;
      overallRating += rating * count;
      ratingPercentages[rating] =
          totalReviews > 0 ? (count / totalReviews) * 100 : 0.0;
    }

    // Finalize overall rating (average)
    overallRating = totalReviews > 0 ? overallRating / totalReviews : 0.0;
  }
}
