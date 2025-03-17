import 'dart:io';
import 'package:emerald_beauty/api_classes/uploading/upload_files.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilePickerService {
  UploadFiles upload = UploadFiles();
  Future<String> addFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Restrict to image files only
      );

      if (result != null && result.files.isNotEmpty) {
        File file = File(result.files.single.path!);

        // Upload to S3
        String imageUrl = await upload.uploadFileToS3(file);
        return imageUrl;
      } else {
        debugPrint("No file selected");
        return ""; // Return an empty string if no file is selected
      }
    } catch (e) {
      debugPrint("Error selecting file: $e");
      return ""; // Return an empty string in case of an error
    }
  }
}
