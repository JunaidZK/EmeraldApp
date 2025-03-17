class TermsAndConditions {
  final bool status;
  final String message;
  final TermsData? data;

  TermsAndConditions({
    required this.status,
    required this.message,
    this.data, // Nullable to handle cases where data is null
  });

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null && json["data"] is Map<String, dynamic>
          ? TermsData.fromJson(json["data"])
          : null, // Ensure proper null or type handling
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson(), // Use nullable access
    };
  }
}

class TermsData {
  final int id;
  final String slug;
  final String title;
  final String content;
  final String arabicContent;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  TermsData({
    required this.id,
    required this.slug,
    required this.title,
    required this.content,
    required this.arabicContent,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TermsData.fromJson(Map<String, dynamic> json) {
    return TermsData(
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
