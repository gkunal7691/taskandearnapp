import 'package:task_and_earn/models/become_a_earner/Professional.dart';
import 'package:task_and_earn/models/post_a_job/Category.dart';
import 'User.dart';

class TaskResponse {
  List<Task> data;
  bool success;

  TaskResponse({
    this.data,
    this.success,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
    data: List<Task>.from(json["data"].map((x) => Task.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
  };
}

class Task {
  int taskId;
  int addressId;
  dynamic userId;
  int categoryId;
  String title;
  String description;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Professional> professionals;
  User user;
  Address address;

  Task({
    this.taskId,
    this.addressId,
    this.userId,
    this.categoryId,
    this.title,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.professionals,
    this.user,
    this.address,
  });

  factory Task.fromJson(Map<dynamic, dynamic> json) => Task(
    taskId: json["taskId"],
    addressId: json["addressId"],
    userId: json["userId"],
    categoryId: json["categoryId"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    createdAt: DateTime.tryParse(json["createdAt"]),
    updatedAt: DateTime.tryParse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    professionals: json["professionals"] != null ? List<Professional>.from(json["professionals"].map((x) => x)) : [],
    user: User.fromJson(json["User"]),
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "addressId": addressId,
    "userId": userId,
    "categoryId": categoryId,
    "title": title,
    "description": description,
    "price": price,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
    "professionals": professionals.length != 0 ? List<Professional>.from(professionals.map((x) => x)) : [],
    "User": user.toJson(),
    "address": address.toJson(),
  };
}