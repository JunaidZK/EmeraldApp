class RefundPolicy {
  final bool status;
  final String message;
  final RefundData? data;

  RefundPolicy({
    required this.status,
    required this.message,
    this.data,
  });

  factory RefundPolicy.fromJson(Map<String, dynamic> json) {
    return RefundPolicy(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null ? RefundData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class RefundData {
  final int id;
  final String slug;
  final String title;
  final String content;
  final String arabicContent;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  RefundData({
    required this.id,
    required this.slug,
    required this.title,
    required this.content,
    required this.arabicContent,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory RefundData.fromJson(Map<String, dynamic> json) {
    return RefundData(
      id: json["id"] ?? 0,
      slug: json["slug"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      arabicContent: json["arabic_content"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      deletedAt: json["deleted_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "slug": slug,
      "title": title,
      "content": content,
      "arabic_content": arabicContent,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "deleted_at": deletedAt,
    };
  }
}
