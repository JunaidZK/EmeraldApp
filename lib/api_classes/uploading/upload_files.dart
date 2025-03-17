import 'dart:io';

import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/s3_upload_response/upload_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UploadFiles {
  ParseApi api = ParseApi();
  Future<String> uploadFileToS3(File file) async {
    try {
      var response = await getS3Config();
      response as UploadResponse;

      final String s3Url = response.data.result.url;
      final UploadFields fields = response.data.result.fields;

      if (s3Url.isEmpty) {
        throw Exception("Invalid S3 configuration received.");
      }

      var request = http.MultipartRequest('POST', Uri.parse(s3Url));

      // Add required fields
      request.fields['Key'] = fields.key;
      request.fields['Content-Type'] = fields.contentType;
      request.fields['bucket'] = fields.bucket;
      request.fields['X-Amz-Algorithm'] = fields.algorithm;
      request.fields['X-Amz-Credential'] = fields.credential;
      request.fields['X-Amz-Date'] = fields.date;
      request.fields['Policy'] = fields.policy;
      request.fields['X-Amz-Signature'] = fields.signature;

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          // contentType: MediaType('image', 'jpeg'),
        ),
      );

      var uploadToS3 = await request.send();

      if (uploadToS3.statusCode >= 200 && uploadToS3.statusCode < 300) {
        return response.data.url;
      } else {
        throw Exception("Failed to upload file: ${uploadToS3.statusCode}");
      }
    } catch (e) {
      debugPrint("Error uploading file: $e");
      rethrow;
    }
  }

  getS3Config() async {
    var param = {"content_type": "image/video/doc/pdf"};
    var response = await api.makeRequest(
        url: ApiUrls.s3config, method: Method.POST, params: param);
    final result = UploadResponse.fromJson(response);
    return result;
  }
}
