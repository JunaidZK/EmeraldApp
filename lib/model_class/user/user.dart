class UserModel {
  final bool status;
  final String message;
  final UserData data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
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

class UserData {
  final User user;
  final AccessToken accessToken;

  UserData({
    required this.user,
    required this.accessToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      accessToken: AccessToken.fromJson(json['access_token']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken.toJson(),
    };
  }
}

class User {
  final int id;
  final String? email;
  final String? phone;
  final String firstName;
  final String userName;
  final String lastName;
  final double? latitude;
  final double? longitude;
  final bool isVerified;
  final bool isCompleted;
  final bool isSocialLogin;
  final bool isApproved;
  final int? salary;
  final String? bio;
  final String shiftStartTime;
  final String shiftEndTime;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final bool pushNotification;
  final bool isActive;
  final List<Role> roles;
  final UserImage? userImage;

  User(
      {required this.id,
      this.email,
      this.phone,
      required this.firstName,
      required this.userName,
      required this.lastName,
      this.latitude,
      this.longitude,
      required this.isVerified,
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
      required this.roles,
      this.userImage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phone: json["phone"],
      firstName: json['first_name'],
      userName: json['user_name'],
      lastName: json['last_name'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      isVerified: json['is_verified'] == 1,
      isCompleted: json['is_completed'] == 1,
      isSocialLogin: json['is_social_login'] == 1,
      isApproved: json['is_approved'] == 1,
      salary: json['salary'],
      bio: json['bio'],
      shiftStartTime: json['shift_start_time'],
      shiftEndTime: json['shift_end_time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      pushNotification: json['push_notification'] == 1,
      isActive: json['is_active'] == 1,
      roles:
          (json['roles'] as List).map((role) => Role.fromJson(role)).toList(),
      userImage: json['user_image'] != null
          ? UserImage.fromJson(json['user_image'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'first_name': firstName,
      'user_name': userName,
      'last_name': lastName,
      'latitude': latitude,
      'longitude': longitude,
      'is_verified': isVerified ? 1 : 0,
      'is_completed': isCompleted ? 1 : 0,
      'is_social_login': isSocialLogin ? 1 : 0,
      'is_approved': isApproved ? 1 : 0,
      'salary': salary,
      'bio': bio,
      'shift_start_time': shiftStartTime,
      'shift_end_time': shiftEndTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'push_notification': pushNotification ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'roles': roles.map((role) => role.toJson()).toList(),
      'user_image': userImage?.toJson(),
    };
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
      permissions: (json['permissions'] as List)
          .map((perm) => Permission.fromJson(perm))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display_name': displayName,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'permissions': permissions.map((perm) => perm.toJson()).toList(),
    };
  }
}

class Permission {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  Permission({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class AccessToken {
  final String type;
  final String token;
  final String expiresAt;

  AccessToken({
    required this.type,
    required this.token,
    required this.expiresAt,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      type: json['type'],
      token: json['token'],
      expiresAt: json['expires_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'token': token,
      'expires_at': expiresAt,
    };
  }
}

class UserImage {
  final int id;
  final String path;
  final String mediaUrl;
  final String? smallImage;
  final String? mediumImage;

  UserImage({
    required this.id,
    required this.path,
    required this.mediaUrl,
    this.smallImage,
    this.mediumImage,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      id: json['id'],
      path: json['path'],
      mediaUrl: json['mediaUrl'],
      smallImage: json['smallImage'],
      mediumImage: json['mediumImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'mediaUrl': mediaUrl,
      'smallImage': smallImage,
      'mediumImage': mediumImage,
    };
  }
}
