class FaqResponse {
  bool status;
  String message;
  Data data;

  FaqResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) {
    return FaqResponse(
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
  Meta meta;
  List<Faq> data;

  Data({
    required this.meta,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: Meta.fromJson(json['meta']),
      data: List<Faq>.from(json['data'].map((x) => Faq.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class Meta {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  int firstPage;
  String firstPageUrl;
  String lastPageUrl;
  String? nextPageUrl;
  String? previousPageUrl;

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

class Faq {
  int id;
  String question;
  String answer;
  String arabicQuestion;
  String arabicAnswer;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String createdAgo;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.arabicQuestion,
    required this.arabicAnswer,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.createdAgo,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      arabicQuestion: json['arabic_question'],
      arabicAnswer: json['arabic_answer'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      createdAgo: json['created_ago'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'arabic_question': arabicQuestion,
      'arabic_answer': arabicAnswer,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'created_ago': createdAgo,
    };
  }
}
