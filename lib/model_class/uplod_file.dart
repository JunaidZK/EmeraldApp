class UploadFile {
  String path;
  String type;

  UploadFile({required this.path, required this.type});

  Map<String, dynamic> toJson() {
    return {
      "path": path,
      "type": type,
    };
  }
}
