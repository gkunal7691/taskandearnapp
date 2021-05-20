import 'Category.dart';
import '../User.dart';

class Task {
  int taskId;
  int addressId;
  String categoryId;
  dynamic createdAt;
  String description;
  String price;
  String title;
  dynamic updatedAt;
  int userId;

  Task({
    this.taskId,
    this.addressId,
    this.categoryId,
    this.createdAt,
    this.description,
    this.price,
    this.title,
    this.updatedAt,
    this.userId,
  });

  factory Task.fromJson(Map<dynamic, dynamic> json) => Task(
    taskId: json["taskId"],
    addressId: json["addressId"],
    categoryId: json["categoryId"],
    createdAt: json["createdAt"],
    description: json["description"],
    price: json["price"],
    title: json["title"],
    updatedAt: json["updatedAt"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "addressId": addressId,
    "categoryId": categoryId,
    "createdAt": createdAt,
    "description": description,
    "price": price,
    "title": title,
    "updatedAt": updatedAt,
    "userId": userId,
  };
}

class TaskRequest {
  String categoryId;
  String title;
  String description;
  String price;
  List<int> subCatagoriesId;
  Address address;
  User user;

  TaskRequest({
    this.categoryId,
    this.title,
    this.description,
    this.price,
    this.subCatagoriesId,
    this.address,
    this.user,
  });

  factory TaskRequest.fromJson(Map<String, dynamic> json) => TaskRequest(
    categoryId: json["categoryId"],
    address: Address.fromJson(json["address"]),
    subCatagoriesId: List.from(json["subCatagoriesId"].map((e) => e)),
    title: json["title"],
    description: json["description"],
    price: json["price"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "categoryId": categoryId != null ? categoryId : null,
      "title": title != null ? title : null,
      "description": description != null ? description : null,
      "price": price != null ? price : null,
      "subCatagoriesId": subCatagoriesId,
      "address": address != null ? address.toJson() : null,
      "user": user != null ? user.toJson() : null,
    };
    return map;
  }
}