class BookingAnalyticsResponse {
  final bool status;
  final String message;
  final List<BookingAnalyticsData> data;

  BookingAnalyticsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return BookingAnalyticsResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((item) => BookingAnalyticsData.fromJson(item))
              .toList()
          : [],
    );
  }
}

class BookingAnalyticsData {
  final Meta meta;

  BookingAnalyticsData({
    required this.meta,
  });

  factory BookingAnalyticsData.fromJson(Map<String, dynamic> json) {
    return BookingAnalyticsData(
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meta {
  final int totalEarnings;
  final int commisionDeductions;
  final int completedBookings;
  final int totalBookings;
  final int completedEarnings;
  final int pendingEarnings;

  Meta({
    required this.totalEarnings,
    required this.commisionDeductions,
    required this.completedBookings,
    required this.totalBookings,
    required this.completedEarnings,
    required this.pendingEarnings,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalEarnings: json['totalEarnings'],
      commisionDeductions: json['commisionDeductions'],
      completedBookings: json['completedBookings'],
      totalBookings: json['totalBookings'],
      completedEarnings: json['completedEarnings'],
      pendingEarnings: json['pendingEarnings'],
    );
  }
}
