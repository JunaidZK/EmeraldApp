class UploadResponse {
  bool status;
  String message;
  UploadData data;

  UploadResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      status: json['status'],
      message: json['message'],
      data: UploadData.fromJson(json['data']),
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

class UploadData {
  UploadResult result;
  String url;

  UploadData({
    required this.result,
    required this.url,
  });

  factory UploadData.fromJson(Map<String, dynamic> json) {
    return UploadData(
      result: UploadResult.fromJson(json['result']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result.toJson(),
      'url': url,
    };
  }
}

class UploadResult {
  String url;
  UploadFields fields;

  UploadResult({
    required this.url,
    required this.fields,
  });

  factory UploadResult.fromJson(Map<String, dynamic> json) {
    return UploadResult(
      url: json['url'],
      fields: UploadFields.fromJson(json['fields']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'fields': fields.toJson(),
    };
  }
}

class UploadFields {
  String key;
  String contentType;
  String bucket;
  String algorithm;
  String credential;
  String date;
  String policy;
  String signature;

  UploadFields({
    required this.key,
    required this.contentType,
    required this.bucket,
    required this.algorithm,
    required this.credential,
    required this.date,
    required this.policy,
    required this.signature,
  });

  factory UploadFields.fromJson(Map<String, dynamic> json) {
    return UploadFields(
      key: json['Key'],
      contentType: json['Content-Type'],
      bucket: json['bucket'],
      algorithm: json['X-Amz-Algorithm'],
      credential: json['X-Amz-Credential'],
      date: json['X-Amz-Date'],
      policy: json['Policy'],
      signature: json['X-Amz-Signature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Key': key,
      'Content-Type': contentType,
      'bucket': bucket,
      'X-Amz-Algorithm': algorithm,
      'X-Amz-Credential': credential,
      'X-Amz-Date': date,
      'Policy': policy,
      'X-Amz-Signature': signature,
    };
  }
}
