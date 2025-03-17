class BookingResponse {
  final bool status;
  final String message;
  final Data data;

  BookingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final Meta meta;
  final List<Booking> data;

  Data({
    required this.meta,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: Meta.fromJson(json['meta']),
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Booking.fromJson(item))
              .toList() ??
          [],
    );
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
}

class Booking {
  final int id;
  final int serviceId;
  final int clientId;
  final int providerId;
  final String date;
  final String startTime;
  final String endTime;
  final int amount;
  final int status;
  final int userAddressId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int userServiceId;
  final int paymentStatus;
  final double adminCut;
  final int userPaymentStatus;
  final Service? service;
  final Provider? provider;
  final Client client;
  final String createdAgo;
  final String statusText;
  final String paymentStatusText;
  final String userPaymentStatusText;
  final Map<String, dynamic> meta;

  Booking({
    required this.id,
    required this.serviceId,
    required this.clientId,
    required this.providerId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.status,
    required this.userAddressId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userServiceId,
    required this.paymentStatus,
    required this.adminCut,
    required this.userPaymentStatus,
    required this.client,
    required this.service,
    required this.provider,
    required this.createdAgo,
    required this.statusText,
    required this.paymentStatusText,
    required this.userPaymentStatusText,
    required this.meta,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      serviceId: json['service_id'],
      clientId: json['client_id'],
      providerId: json['provider_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      amount: json['amount'],
      status: json['status'],
      userAddressId: json['user_address_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      userServiceId: json['user_service_id'],
      paymentStatus: json['payment_status'],
      adminCut: json['admin_cut'].toDouble(),
      userPaymentStatus: json['user_payment_status'],
      client: json["client"] != null
          ? Client.fromJson(json["client"])
          : Client(firstName: '', lastName: '', id: 0, meta: {}),
      service: json['service'] != null
          ? Service.fromJson(json['service'])
          : Service(name: '', arabicName: '', id: 0, meta: {}),
      provider: json['provider'] != null
          ? Provider.fromJson(json['provider'])
          : Provider(firstName: '', lastName: '', id: 0, meta: {}),
      createdAgo: json['created_ago'] ?? '',
      statusText: json['status_text'] ?? '',
      paymentStatusText: json['payment_status_text'] ?? '',
      userPaymentStatusText: json['user_payment_status_text'] ?? '',
      meta: json['meta'] ?? {}, // Assign an empty map if meta is null
    );
  }
}

class Service {
  final String name;
  final String arabicName;
  final int id;
  final Map<String, dynamic> meta;

  Service({
    required this.name,
    required this.arabicName,
    required this.id,
    required this.meta,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      arabicName: json['arabic_name'],
      id: json['id'],
      meta: json['meta'],
    );
  }
}

class Provider {
  final String firstName;
  final String lastName;
  final int id;
  final Map<String, dynamic> meta;

  Provider({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.meta,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      firstName: json['first_name'],
      lastName: json['last_name'],
      id: json['id'],
      meta: json['meta'],
    );
  }
}

class Client {
  final String firstName;
  final String lastName;
  final int id;
  final Map<String, dynamic> meta;

  Client({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.meta,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      firstName: json['first_name'],
      lastName: json['last_name'],
      id: json['id'],
      meta: json['meta'],
    );
  }
}
