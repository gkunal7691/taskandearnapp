import '../Task_Model.dart';
import 'Category.dart';
import '../User.dart';
import 'PostAJob.dart';

// class Task {
//   int taskId;
//   int addressId;
//   String categoryId;
//   String description;
//   String price;
//   String title;
//   int userId;
//   dynamic createdAt;
//   dynamic updatedAt;
//
//   Task({
//     this.taskId,
//     this.addressId,
//     this.categoryId,
//     this.createdAt,
//     this.description,
//     this.price,
//     this.title,
//     this.updatedAt,
//     this.userId,
//   });
//
//   factory Task.fromJson(Map<dynamic, dynamic> json) => Task(
//     taskId: json["taskId"],
//     addressId: json["addressId"],
//     categoryId: json["categoryId"],
//     createdAt: json["createdAt"],
//     description: json["description"],
//     price: json["price"],
//     title: json["title"],
//     updatedAt: json["updatedAt"],
//     userId: json["userId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "taskId": taskId,
//     "addressId": addressId,
//     "categoryId": categoryId,
//     "createdAt": createdAt,
//     "description": description,
//     "price": price,
//     "title": title,
//     "updatedAt": updatedAt,
//     "userId": userId,
//   };
// }

class TaskRequest {
  CategoryData categoryData;
  Task task;
  User user;
  Address address;

  TaskRequest({
    this.categoryData,
    this.task,
    this.user,
    this.address,
  });

  factory TaskRequest.fromJson(Map<String, dynamic> json) => TaskRequest(
    categoryData: json["categoryData"],
    task: json["task"],
    user: User.fromJson(json["user"]),
    address: json["address"],
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "categoryData": categoryData != null ? categoryData.toJson() : null,
      "task": task != null ? task.toJson() : null,
      "user": user != null ? user.toJson() : null,
      "address": address != null ? address.toJson() : null,
    };
    return map;
  }
}