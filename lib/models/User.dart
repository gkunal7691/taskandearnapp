class User {
  int userId;
  String firstName;
  String lastName;
  String email;
  int exp;
  int iat;
  dynamic professionalId;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.exp,
    this.iat,
    this.professionalId,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    exp: json["exp"],
    iat: json["iat"],
    professionalId: json["professionalId"],
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
        "professionalId": professionalId != null ? professionalId : null,
      };
      return map;
    } catch(e) {
      print("um $e");
      return null;
    }
  }
}