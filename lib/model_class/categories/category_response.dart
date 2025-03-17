class CategoryResponse {
  final int categoryId;
  final String categoryName;
  final String arbaicCategoryName;

  CategoryResponse({
    required this.categoryId,
    required this.categoryName,
    required this.arbaicCategoryName,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
        categoryId: json["id"],
        categoryName: json["name"],
        arbaicCategoryName: json["arabic_name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': categoryId,
      'name': categoryName,
      "arabic_name": arbaicCategoryName
    };
  }
}
