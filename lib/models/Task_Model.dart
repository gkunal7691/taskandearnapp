import 'Professional.dart';
import 'package:task_and_earn/models/post_a_job/Category.dart';
import 'User.dart';

class TaskResponse {
  bool success;
  List<Task> data;

  TaskResponse({
    this.success,
    this.data
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) => new TaskResponse(
    success: json["success"],
    data: List<Task>.from(json["data"].map((x) => Task.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<Task>.from(data.map((x) => x.toJson()))
  };
}

class Task {
  int taskId;
  String title;
  String description;
  int price;
  String name;
  String postType;

  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  int categoryId;
  int addressId;
  int userId;

  Address address;
  User user;
  List<Professional> professionals;

  Task({
    this.taskId,
    this.addressId,
    this.userId,
    this.categoryId,
    this.title,
    this.description,
    this.price,
    this.name,
    this.postType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.address,
    this.user,
    this.professionals,
  });

  factory Task.fromJson(Map<dynamic, dynamic> json) => new Task(
    taskId: json["taskId"],
    addressId: json["addressId"],
    userId: json["userId"] != null ? json["userId"] : null,
    categoryId: json["categoryId"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    name: json["name"],
    postType: json["postType"],
    createdAt: DateTime.tryParse(json["createdAt"]),
    updatedAt: DateTime.tryParse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    address: Address.fromJson(json["address"]),
    user: json["User"] != null ? User.fromJson(json["User"]) : null,
    professionals: json["professionals"] != null ? List<Professional>.from(json["professionals"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "addressId": addressId,
    "userId": userId != null ? userId : null,
    "categoryId": categoryId,
    "title": title,
    "description": description,
    "price": price,
    "name": name,
    "postType": postType,
    "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
    "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
    "deletedAt": deletedAt,
    "address": address != null ? address.toJson() : null,
    "User": user != null ? user.toJson() : null,
    "professionals": professionals != null ? professionals.length != 0 ? List<Professional>.from(professionals.map((x) => x)) : [] : [],
  };
}