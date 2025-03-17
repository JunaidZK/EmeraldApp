import 'dart:convert';

class EmployeeServices {
  final bool status;
  final String message;
  final Meta? meta;
  final List<ServiceData> data;

  EmployeeServices({
    required this.status,
    required this.message,
    this.meta,
    required this.data,
  });

  factory EmployeeServices.fromJson(String str) =>
      EmployeeServices.fromMap(json.decode(str));

  factory EmployeeServices.fromMap(Map<String, dynamic> json) =>
      EmployeeServices(
        status: json["status"],
        message: json["message"],
        meta: Meta.fromMap(json["data"]["meta"]),
        data: List<ServiceData>.from(
            json["data"]["data"].map((x) => ServiceData.fromMap(x))),
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

class ServiceData {
  final int id;
  final int userId;
  final int serviceId;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdAgo;
  final Service? service;
  final List<Portfolio> portfolio;

  ServiceData({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAgo,
    this.service,
    required this.portfolio,
  });

  factory ServiceData.fromMap(Map<String, dynamic> json) => ServiceData(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        price: (json["price"] as num).toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAgo: json["created_ago"],
        service:
            json["service"] != null ? Service.fromMap(json["service"]) : null,
        portfolio: json["potfolio"] != null
            ? List<Portfolio>.from(
                json["potfolio"].map((x) => Portfolio.fromMap(x)))
            : [],
      );
}

class Service {
  final int id;
  final String name;
  final String arabicName;
  final double price;
  final int categoryId;
  final String description;
  final String arabicDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int duration;
  final String createdAgo;

  Service({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.price,
    required this.categoryId,
    required this.description,
    required this.arabicDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
    required this.createdAgo,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        price: (json["price"] as num).toDouble(),
        categoryId: json["category_id"],
        description: json["description"],
        arabicDescription: json["arabic_description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        duration: json["duration"],
        createdAgo: json["created_ago"],
      );
}

class Portfolio {
  final int id;
  final String path;
  final String mediaUrl;
  final String smallImage;
  final String mediumImage;

  Portfolio({
    required this.id,
    required this.path,
    required this.mediaUrl,
    required this.smallImage,
    required this.mediumImage,
  });

  factory Portfolio.fromMap(Map<String, dynamic> json) => Portfolio(
        id: json["id"],
        path: json["path"],
        mediaUrl: json["mediaUrl"],
        smallImage: json["smallImage"],
        mediumImage: json["mediumImage"],
      );
}
