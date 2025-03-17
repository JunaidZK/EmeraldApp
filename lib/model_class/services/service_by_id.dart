class ServiceByIdResponse {
  final bool status;
  final String message;
  final ServiceByIdData data;

  ServiceByIdResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ServiceByIdResponse.fromJson(Map<String, dynamic> json) {
    return ServiceByIdResponse(
      status: json['status'],
      message: json['message'],
      data: ServiceByIdData.fromJson(json['data']),
    );
  }
}

class ServiceByIdData {
  final int id;
  final String name;
  final String arabicName;
  final int price;
  final int categoryId;
  final String description;
  final String arabicDescription;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int duration;
  final CoverPhoto coverPhoto;
  final String createdAgo;

  ServiceByIdData({
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
    required this.coverPhoto,
    required this.createdAgo,
  });

  factory ServiceByIdData.fromJson(Map<String, dynamic> json) {
    return ServiceByIdData(
      id: json['id'],
      name: json['name'],
      arabicName: json['arabic_name'],
      price: json['price'],
      categoryId: json['category_id'],
      description: json['description'],
      arabicDescription: json['arabic_description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      duration: json['duration'],
      coverPhoto: CoverPhoto.fromJson(json['cover_photo']),
      createdAgo: json['created_ago'],
    );
  }
}

class CoverPhoto {
  final int id;
  final String path;
  final int instanceType;
  final int instanceId;
  final String mimeType;
  final String? thumbnail;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String mediaUrl;
  final String smallImage;
  final String mediumImage;

  CoverPhoto({
    required this.id,
    required this.path,
    required this.instanceType,
    required this.instanceId,
    required this.mimeType,
    this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.mediaUrl,
    required this.smallImage,
    required this.mediumImage,
  });

  factory CoverPhoto.fromJson(Map<String, dynamic> json) {
    return CoverPhoto(
      id: json['id'],
      path: json['path'],
      instanceType: json['instance_type'],
      instanceId: json['instance_id'],
      mimeType: json['mime_type'],
      thumbnail: json['thumbnail'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      mediaUrl: json['mediaUrl'],
      smallImage: json['smallImage'],
      mediumImage: json['mediumImage'],
    );
  }
}
