class UserResponse {
  final bool success;
  final User user;

  UserResponse({
    this.success,
    this.user
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json["success"],
      user: User.fromJson(json["data"])
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user.toJson()
  };
}

class User {
  int userId;
  String firstName;
  String lastName;
  String email;
  int exp;
  int iat;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.exp,
    this.iat,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    exp: json["exp"],
    iat: json["iat"],
  );

  Map<String, dynamic> toJson() {
    try {
      Map<String, dynamic> map = {
        "userId": userId != null ? userId : null,
        "firstName": firstName != null ? firstName : null,
        "lastName": lastName != null ? lastName : null,
        "email": email != null ? email : null,
        "exp": exp != null ? exp : null,
        "iat": iat != null ? iat : null,
      };
      return map;
    } catch(e) {
      print("um $e");
      return null;
    }
  }
}