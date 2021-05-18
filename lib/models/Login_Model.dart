import 'package:task_and_earn/models/Util_Model.dart';

class LoginResponseModel {
  final bool success;
  final ResponseError error;
  final Token data;

  LoginResponseModel({this.success, this.error, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if(json["success"]) {
      return LoginResponseModel(
        success: json["success"],
        data: Token.fromJson(json["data"]),
      );
    } else {
      return LoginResponseModel(
        success: json["success"],
        error: ResponseError.fromJson(json["error"]),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error.toJson(),
  };
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email != null ? email.trim() : null,
      "password": password != null ? password.trim() : null,
    };
    return map;
  }
}