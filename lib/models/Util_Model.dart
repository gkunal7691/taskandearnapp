
class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    // print("Token json: $json");
    return Token(
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}

class ResponseError {
  String name;

  ResponseError({this.name});

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    return ResponseError(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}