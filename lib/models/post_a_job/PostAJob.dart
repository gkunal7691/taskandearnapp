import 'package:flutter/foundation.dart' hide Category;
import 'package:task_and_earn/models/post_a_job/Category.dart';
import '../Task_Model.dart';

class PostAJobResponse {
  final bool success;
  final Task data;

  PostAJobResponse({this.success, this.data});

  factory PostAJobResponse.fromJson(Map<String, dynamic> json) => PostAJobResponse(
    success: json["success"],
    data: Task.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class CategoryData {
  Category selectedCategory;
  int category;
  PostType postType;
  String name;

  CategoryData({
    this.selectedCategory,
    this.category,
    this.postType,
    this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "selectedCategory": selectedCategory != null ? selectedCategory.toJson() : null,
      "category": category != null ? category : null,
      "postType": postType != null ? postType.name : null,
      "name": name != null ? name.trim() : null,
    };
    return map;
  }
}

enum PostType {
  individual,
  company
}

extension PostTypeValue on PostType {
  String get name => describeEnum(this);
}