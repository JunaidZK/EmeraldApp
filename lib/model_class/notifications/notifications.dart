import 'dart:convert';

class NotificationResponse {
  final bool status;
  final String message;
  final Meta meta;
  final List<NotificationData> data;

  NotificationResponse({
    required this.status,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory NotificationResponse.fromJson(String str) =>
      NotificationResponse.fromMap(json.decode(str));

  factory NotificationResponse.fromMap(Map<String, dynamic> json) =>
      NotificationResponse(
        status: json["status"],
        message: json["message"],
        meta: Meta.fromMap(json["data"]["meta"]),
        data: List<NotificationData>.from(
            json["data"]["data"].map((x) => NotificationData.fromMap(x))),
      );
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

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        firstPage: json["first_page"],
        firstPageUrl: json["first_page_url"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        previousPageUrl: json["previous_page_url"],
      );
}

class NotificationData {
  final int id;
  final int notifiableId;
  final String title;
  final String message;
  final int type;
  final String? readAt;
  final String extra;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String createdAgo;

  NotificationData({
    required this.id,
    required this.notifiableId,
    required this.title,
    required this.message,
    required this.type,
    this.readAt,
    required this.extra,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.createdAgo,
  });

  factory NotificationData.fromMap(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"],
        notifiableId: json["notifiable_id"],
        title: json["title"],
        message: json["message"],
        type: json["type"],
        readAt: json["read_at"],
        extra: json["extra"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        createdAgo: json["created_ago"],
      );
}
