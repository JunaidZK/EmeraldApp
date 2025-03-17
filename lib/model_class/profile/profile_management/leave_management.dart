class LeaveResponse {
  final bool status;
  final String message;
  final Meta meta;
  final List<LeaveData> data;

  LeaveResponse({
    required this.status,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory LeaveResponse.fromJson(Map<String, dynamic> json) {
    return LeaveResponse(
      status: json['status'],
      message: json['message'],
      meta: Meta.fromJson(json['data']['meta']),
      data: (json['data']['data'] as List)
          .map((item) => LeaveData.fromJson(item))
          .toList(),
    );
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
}

class LeaveData {
  final int id;
  final int type;
  final String subject;
  final String reason;
  final int status;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String startDate;
  final String endDate;
  final String createdAgo;
  final String leaveStatusText;
  final String leaveTypeText;

  LeaveData({
    required this.id,
    required this.type,
    required this.subject,
    required this.reason,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.startDate,
    required this.endDate,
    required this.createdAgo,
    required this.leaveStatusText,
    required this.leaveTypeText,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      id: json['id'],
      type: json['type'],
      subject: json['subject'],
      reason: json['reason'],
      status: json['status'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAgo: json['created_ago'],
      leaveStatusText: json['leave_status_text'],
      leaveTypeText: json['leave_type_text'],
    );
  }
}
