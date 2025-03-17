class GraphResponse {
  final bool status;
  final String message;
  final List<DayData> data;

  GraphResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GraphResponse.fromJson(Map<String, dynamic> json) {
    return GraphResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((item) => DayData.fromJson(item))
              .toList()
          : [],
    );
  }
}

class DayData {
  final String day;
  final int completedCount;
  final int cancelledCount;
  final int totalRevenue;
  final int adminCut;

  DayData({
    required this.day,
    required this.completedCount,
    required this.cancelledCount,
    required this.totalRevenue,
    required this.adminCut,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      day: json['day'],
      completedCount: json['completed_count'],
      cancelledCount: json['cancelled_count'],
      totalRevenue: json['total_revenue'],
      adminCut: json['admin_cut'],
    );
  }
}
