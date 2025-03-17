class PrivacyPolicy {
  final bool status;
  final String message;
  final PrivacyData? data;

  PrivacyPolicy({
    required this.status,
    required this.message,
    this.data,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicy(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null ? PrivacyData.fromJson(json["data"]) : null,
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

class PrivacyData {
  final int id;
  final String slug;
  final String title;
  final String content;
  final String arabicContent;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  PrivacyData({
    required this.id,
    required this.slug,
    required this.title,
    required this.content,
    required this.arabicContent,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PrivacyData.fromJson(Map<String, dynamic> json) {
    return PrivacyData(
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
