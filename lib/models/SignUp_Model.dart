
class SignUpResponseModel {
  final bool success;
  final Data data;

  SignUpResponseModel({this.success, this.data});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );
}

class Data {
  int userId;
  String firstName;
  String lastName;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class SignUpRequestModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;

  SignUpRequestModel({this.firstName, this.lastName, this.email, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "firstName": firstName != null ? firstName.trim() : null,
      "lastName": lastName != null ? lastName.trim() : null,
      "email": email != null ? email.trim() : null,
      "password": password != null ? password.trim() : null,
      "confirmPassword": confirmPassword != null ? confirmPassword.trim() : null,
    };
    return map;
  }
}