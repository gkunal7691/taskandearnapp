import 'Task.dart';

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