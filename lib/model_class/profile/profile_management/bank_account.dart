class BankAccount {
  int id;
  String name;
  String bankName;
  String accountNumber;
  String iban;
  String? swiftCode;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  String createdAgo;
  Meta meta;

  BankAccount({
    required this.id,
    required this.name,
    required this.bankName,
    required this.accountNumber,
    required this.iban,
    this.swiftCode,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.createdAgo,
    required this.meta,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'],
      name: json['name'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      iban: json['iban'],
      swiftCode: json['swift_code'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      createdAgo: json['created_ago'],
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bank_name': bankName,
      'account_number': accountNumber,
      'iban': iban,
      'swift_code': swiftCode,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'created_ago': createdAgo,
      'meta': meta.toJson(),
    };
  }
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
