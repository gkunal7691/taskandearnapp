import 'Category.dart';

class SubCategoryResponse {
  final bool success;
  final List<SubCategory> data;

  SubCategoryResponse({this.success, this.data});

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) => SubCategoryResponse(
    success: json["success"],
    data: List<SubCategory>.from(json["data"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubCategory {
  // ignore: non_constant_identifier_names
  final String SubCategoryName;
  final Category category;
  final int categoryId;
  final dynamic createdAt;
  final dynamic deletedAt;
  final String description;
  final int subCategoryId;
  final dynamic updatedAt;

  SubCategory(
      // ignore: non_constant_identifier_names
      {this.SubCategoryName,
      this.category,
      this.categoryId,
      this.createdAt,
      this.deletedAt,
      this.description,
      this.subCategoryId,
      this.updatedAt});

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    SubCategoryName: json["SubCategoryName"],
    categoryId: json["categoryId"],
    createdAt: json["createdAt"],
    deletedAt: json["deletedAt"],
    description: json["description"],
    subCategoryId: json["subCategoryId"],
    updatedAt: json["updatedAt"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "SubCategoryName": SubCategoryName,
    "categoryId": categoryId,
    "createdAt": createdAt,
    "deletedAt": deletedAt,
    "description": description,
    "subCategoryId": subCategoryId,
    "updatedAt": updatedAt,
    "category": category.toJson(),
  };
}