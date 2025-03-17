import 'dart:convert';

class Services {
  final bool status;
  final String message;
  final Meta meta;
  final List<ServiceResult> data;

  Services({
    required this.status,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory Services.fromJson(String str) => Services.fromMap(json.decode(str));

  factory Services.fromMap(Map<String, dynamic> json) => Services(
        status: json["status"],
        message: json["message"],
        meta: Meta.fromMap(json["data"]["meta"]),
        data: List<ServiceResult>.from(
            json["data"]["data"].map((x) => ServiceResult.fromMap(x))),
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

class ServiceResult {
  final int id;
  final String name;
  final String arabicName;
  final int price;
  final int categoryId;
  final String description;
  final String arabicDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int duration;
  final String createdAgo;
  final Category category; // Added category field

  ServiceResult({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.price,
    required this.categoryId,
    required this.description,
    required this.arabicDescription,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.duration,
    required this.createdAgo,
    required this.category, // Added category in constructor
  });

  factory ServiceResult.fromMap(Map<String, dynamic> json) => ServiceResult(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        price: json["price"],
        categoryId: json["category_id"],
        description: json["description"],
        arabicDescription: json["arabic_description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        duration: json["duration"],
        createdAgo: json["created_ago"],
        category: Category.fromMap(json["category"]), // Parse category object
      );
}

class Category {
  final int id;
  final String name;
  final String arabicName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String createdAgo;

  Category({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.createdAgo,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        createdAgo: json["created_ago"],
      );
}
