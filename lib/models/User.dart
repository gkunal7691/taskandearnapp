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

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest({this.email});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email != null ? email.trim() : null,
    };
    return map;
  }
}

class ForgotPasswordResponse {
  final bool success;
  final ForgotPwdResData forgotPwdResData;
  final String data;

  ForgotPasswordResponse({
    this.success,
    this.forgotPwdResData,
    this.data,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    if(json["success"]) {
      return ForgotPasswordResponse(
        success: json["success"],
        forgotPwdResData: ForgotPwdResData.fromJson(json["data"]),
      );
    } else {
      return ForgotPasswordResponse(
        success: json["success"],
        data: json["data"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": forgotPwdResData.toJson(),
  };
}

class ForgotPwdResData {
  String messageId;
  ResponseMetadata responseMetadata;

  ForgotPwdResData({
    this.messageId,
    this.responseMetadata,
  });

  factory ForgotPwdResData.fromJson(Map<String, dynamic> json) => ForgotPwdResData(
    messageId: json["MessageId"],
    responseMetadata: ResponseMetadata.fromJson(json["ResponseMetadata"]),
  );

  Map<String, dynamic> toJson() => {
    "MessageId": messageId,
    "ResponseMetadata": responseMetadata.toJson(),
  };
}

class ResponseMetadata {
  ResponseMetadata({
    this.requestId,
  });

  String requestId;

  factory ResponseMetadata.fromJson(Map<String, dynamic> json) => ResponseMetadata(
    requestId: json["RequestId"],
  );

  Map<String, dynamic> toJson() => {
    "RequestId": requestId,
  };
}