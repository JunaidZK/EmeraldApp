class ProfileResponse {
  final bool status;
  final String message;
  final ProfileData? data;

  ProfileResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }
}

class ProfileData {
  final Profile? profile;
  final List<UserService>? userServices;

  ProfileData({this.profile, this.userServices});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      userServices: json['user_services'] != null
          ? (json['user_services'] as List<dynamic>)
              .map((service) => UserService.fromJson(service))
              .toList()
          : null,
    );
  }
}

class Profile {
  final int id;
  final String? email;
  final String firstName;
  final String userName;
  final String lastName;
  final double? latitude;
  final double? longitude;
  final int isVerified;
  final String? phone;
  final int isCompleted;
  final int isSocialLogin;
  final int isApproved;
  final double? salary;
  final String? bio;
  final String shiftStartTime;
  final String shiftEndTime;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int pushNotification;
  final int isActive;
  final String? stripeCustomerId;
  final List<Role> roles;
  final UserImage? userImage;
  final String? address;
  final int availabilityStatus;

  Profile(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.userName,
      required this.lastName,
      required this.latitude,
      required this.longitude,
      required this.isVerified,
      this.phone,
      required this.isCompleted,
      required this.isSocialLogin,
      required this.isApproved,
      this.salary,
      this.bio,
      required this.shiftStartTime,
      required this.shiftEndTime,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.pushNotification,
      required this.isActive,
      this.stripeCustomerId,
      required this.roles,
      this.userImage,
      this.address,
      required this.availabilityStatus});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        userName: json['user_name'],
        lastName: json['last_name'],
        latitude: json['latitude'] != null
            ? (json['latitude'] as num).toDouble()
            : null,
        longitude: json['longitude'] != null
            ? (json['longitude'] as num).toDouble()
            : null,
        isVerified: json['is_verified'],
        phone: json['phone'],
        isCompleted: json['is_completed'],
        isSocialLogin: json['is_social_login'],
        isApproved: json['is_approved'],
        salary:
            json['salary'] != null ? (json['salary'] as num).toDouble() : null,
        bio: json['bio'],
        shiftStartTime: json['shift_start_time'],
        shiftEndTime: json['shift_end_time'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deletedAt: json['deleted_at'],
        pushNotification: json['push_notification'],
        isActive: json['is_active'],
        stripeCustomerId: json['stripe_customer_id'],
        roles: (json['roles'] as List<dynamic>)
            .map((role) => Role.fromJson(role))
            .toList(),
        userImage: json['user_image'] != null
            ? UserImage.fromJson(json['user_image'])
            : null,
        address: json['address'],
        availabilityStatus: json["availibility_status"]);
  }
}

class Role {
  final int id;
  final String name;
  final String displayName;
  final String? description;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.displayName,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      displayName: json['display_name'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      permissions: (json['permissions'] as List<dynamic>)
          .map((permission) => Permission.fromJson(permission))
          .toList(),
    );
  }
}

class Permission {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final Meta meta;

  Permission({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.meta,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meta {
  final int pivotRoleId;
  final int pivotModuleId;
  final int pivotCreate;
  final int pivotRead;
  final int pivotUpdate;
  final int pivotDelete;

  Meta({
    required this.pivotRoleId,
    required this.pivotModuleId,
    required this.pivotCreate,
    required this.pivotRead,
    required this.pivotUpdate,
    required this.pivotDelete,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pivotRoleId: json['pivot_role_id'],
      pivotModuleId: json['pivot_module_id'],
      pivotCreate: json['pivot_create'],
      pivotRead: json['pivot_read'],
      pivotUpdate: json['pivot_update'],
      pivotDelete: json['pivot_delete'],
    );
  }
}

class UserImage {
  final int id;
  final String path;
  final int instanceType;
  final int instanceId;
  final String mimeType;
  final String? thumbnail;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? duration;
  final String createdAgo;
  final String mediaUrl;
  final String smallImage;
  final String mediumImage;
  final Map<String, dynamic> meta;

  UserImage({
    required this.id,
    required this.path,
    required this.instanceType,
    required this.instanceId,
    required this.mimeType,
    this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.duration,
    required this.createdAgo,
    required this.mediaUrl,
    required this.smallImage,
    required this.mediumImage,
    required this.meta,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      id: json['id'],
      path: json['path'],
      instanceType: json['instance_type'],
      instanceId: json['instance_id'],
      mimeType: json['mime_type'],
      thumbnail: json['thumbnail'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      duration: json['duration'],
      createdAgo: json['created_ago'],
      mediaUrl: json['mediaUrl'],
      smallImage: json['smallImage'],
      mediumImage: json['mediumImage'],
      meta: json['meta'] ?? {},
    );
  }
}

class UserService {
  final int id;
  final int userId;
  final int serviceId;
  final double price;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String createdAgo;
  final Meta meta;

  UserService({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.createdAgo,
    required this.meta,
  });

  factory UserService.fromJson(Map<String, dynamic> json) {
    return UserService(
      id: json['id'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      price: (json['price'] as num).toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      createdAgo: json['created_ago'],
      meta: Meta.fromJson(json['meta']),
    );
  }
}
