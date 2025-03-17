class ContactInfoResponse {
  final bool status;
  final String message;
  final Data data;

  ContactInfoResponse(
      {required this.status, required this.message, required this.data});

  factory ContactInfoResponse.fromJson(Map<String, dynamic> json) {
    return ContactInfoResponse(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final Meta meta;
  final List<SocialMedia> socialMediaLinks;

  Data({required this.meta, required this.socialMediaLinks});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: Meta.fromJson(json['meta']),
      socialMediaLinks: (json['data'] as List)
          .map((item) => SocialMedia.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': socialMediaLinks.map((item) => item.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'first_page': firstPage,
      'first_page_url': firstPageUrl,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'previous_page_url': previousPageUrl,
    };
  }
}

class SocialMedia {
  final int id;
  final int type;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String iconUrl;
  final String createdAgo;

  SocialMedia({
    required this.id,
    required this.type,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.iconUrl,
    required this.createdAgo,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      id: json['id'],
      type: json['type'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      iconUrl: json['icon']['mediaUrl'],
      createdAgo: json['created_ago'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'url': url,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'icon': {'mediaUrl': iconUrl},
      'created_ago': createdAgo,
    };
  }
}
