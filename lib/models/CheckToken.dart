import 'package:task_and_earn/models/Util_Model.dart';
import 'User.dart';

class CheckTokenResponse {
  final bool success;
  final User user;
  final ResponseError error;

  CheckTokenResponse({
    this.success,
    this.user,
    this.error
  });

  factory CheckTokenResponse.fromJson(Map<String, dynamic> json) {
    if(json["success"]) {
      return CheckTokenResponse(
        success: json["success"],
        user: User.fromJson(json["user"]),
      );
    } else {
      return CheckTokenResponse(
        success: json["success"],
        error: json["error"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user.toJson(),
  };
}