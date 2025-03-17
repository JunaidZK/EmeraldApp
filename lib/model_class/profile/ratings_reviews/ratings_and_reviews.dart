class ReviewResponse {
  final bool status;
  final String message;
  final ReviewListData data;

  ReviewResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      status: json['status'],
      message: json['message'],
      data: ReviewListData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ReviewListData {
  final Meta meta;
  final List<ReviewData> reviews;

  ReviewListData({
    required this.meta,
    required this.reviews,
  });

  factory ReviewListData.fromJson(Map<String, dynamic> json) {
    return ReviewListData(
      meta: Meta.fromJson(json['meta']),
      reviews: (json['data'] as List)
          .map((item) => ReviewData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class Meta {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String? previousPageUrl;

  Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.firstPage,
    required this.firstPageUrl,
    required this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      firstPage: json['first_page'],
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      previousPageUrl: json['previous_page_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'first_page': firstPage,
      'first_page_url': firstPageUrl,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'previous_page_url': previousPageUrl,
    };
  }
}

class ReviewData {
  final int id;
  final int rating;
  final String review;
  final int userId;
  final int userServiceId;
  final int serviceId;
  final int bookingId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int reviewedId;
  final String createdAgo;
  final Map<String, dynamic> meta;
  final UserReview user;

  ReviewData({
    required this.id,
    required this.rating,
    required this.review,
    required this.userId,
    required this.userServiceId,
    required this.serviceId,
    required this.bookingId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.reviewedId,
    required this.createdAgo,
    required this.meta,
    required this.user,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['id'],
      rating: json['rating'],
      review: json['review'],
      userId: json['user_id'],
      userServiceId: json['user_service_id'],
      serviceId: json['service_id'],
      bookingId: json['booking_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      reviewedId: json['reviewed_id'],
      createdAgo: json['created_ago'],
      meta: json['meta'] ?? {},
      user: UserReview.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'review': review,
      'user_id': userId,
      'user_service_id': userServiceId,
      'service_id': serviceId,
      'booking_id': bookingId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'reviewed_id': reviewedId,
      'created_ago': createdAgo,
      'meta': meta,
      'user': user.toJson(),
    };
  }
}

class UserReview {
  final String firstName;
  final String lastName;
  final int id;
  final Map<String, dynamic> meta;

  UserReview({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.meta,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      firstName: json['first_name'],
      lastName: json['last_name'],
      id: json['id'],
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'id': id,
      'meta': meta,
    };
  }
}
