import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:http/http.dart' as http;

class ParseApi {
  // Method to make the API request
  Future<Map<String, dynamic>> makeRequest({
    required String url,
    required Method method,
    Map<String, String>? headers,
    dynamic params,
    bool includeAuth = true,
  }) async {
    try {
      // Default headers for the request
      Map<String, String> defaultHeaders = {
        'Content-Type': 'application/json',
      };

      if (includeAuth && ApiUrls.token != null) {
        defaultHeaders['Authorization'] = ApiUrls.token!;
      }

      // Merge with any custom headers
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }

      // HTTP response variable
      http.Response response;

      // Handle different HTTP methods
      switch (method) {
        case Method.GET:
          // Construct the URL with query parameters if params are provided
          Uri uri = params != null
              ? Uri.parse(ApiUrls.baseUrl + url)
                  .replace(queryParameters: params)
              : Uri.parse(ApiUrls.baseUrl + url);

          response = await http.get(
            uri,
            headers: defaultHeaders,
          );
          break;

        case Method.POST:
          response = await http.post(Uri.parse(ApiUrls.baseUrl + url),
              headers: defaultHeaders,
              body: params != null ? jsonEncode(params) : null);
          break;

        case Method.PUT:
          response = await http.put(
            Uri.parse(ApiUrls.baseUrl + url),
            headers: defaultHeaders,
            body: jsonEncode(params),
          );
          break;

        case Method.DELETE:
          response = await http.delete(
            Uri.parse(ApiUrls.baseUrl + url),
            headers: defaultHeaders,
            body: jsonEncode(params),
          );
          break;
        case Method.PATCH:
          response = await http.patch(
            Uri.parse(ApiUrls.baseUrl + url),
            headers: defaultHeaders,
            body: jsonEncode(params),
          );
          break;
      }

      // Check if the response status is OK (200)
      final responseBody = await parseJsonWithIsolate(response.body);

      // Check response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseBody;
      } else if (response.statusCode == 400) {
        // Return the error message directly if status code is 400
        if (responseBody.containsKey('message')) {
          return {'error': responseBody['message']};
        } else {
          throw Exception(
              'Error: Invalid response format for status code 400.');
        }
      } else {
        // Handle other non-success status codes
        throw Exception(
            'Error: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      // Handle any errors during the request
      throw Exception('Error: $e');
    }
  }

  Future<String?> uploadFile({
    required String url,
    required dynamic files, // This can be a single file or a list of files
    required Map<String, dynamic> fields,
    bool includeAuth = true,
  }) async {
    try {
      // Default headers for the request
      // Map<String, String> defaultHeaders = {
      //   'Content-Type': 'multipart/form-data',
      // };

      // if (includeAuth && ApiUrls.token != null) {
      //   defaultHeaders['Authorization'] = ApiUrls.token!;
      // }

      // Create a multipart request
      var uri = Uri.parse(url);
      var request = http.MultipartRequest("POST", uri);

      // Add custom fields to the request
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Check if files is a single file or a list of files
      if (files is File) {
        // If it's a single file, add it to the request
        request.files
            .add(await http.MultipartFile.fromPath('file', files.path));
      } else if (files is List<File>) {
        // If it's a list of files, add all files to the request
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('file', file.path));
        }
      } else {
        throw Exception("Invalid file format. Expected File or List<File>.");
      }

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 204) {
        // Parse the response body (in case you want to extract data)
        return "$url/${fields['Key']}";
      } else {
        throw Exception(
            'Error: ${response.statusCode}, Response: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      // Handle any errors during the file upload
      throw Exception('Error during file upload: $e');
    }
  }

  Future<Map<String, dynamic>> parseJsonWithIsolate(String responseBody) async {
    final receivePort = ReceivePort();

    // Spawn an isolate to parse the JSON
    await Isolate.spawn(
        _parseJsonInBackground, [responseBody, receivePort.sendPort]);

    // Wait for the result from the isolate
    return await receivePort.first;
  }

  void _parseJsonInBackground(List<dynamic> args) {
    String responseBody = args[0];
    SendPort sendPort = args[1];

    try {
      // Decode the JSON response
      final result = jsonDecode(responseBody);
      // Send the result back to the main thread
      sendPort.send(result);
    } catch (e) {
      sendPort.send({'error': e.toString()});
    }
  }
}
