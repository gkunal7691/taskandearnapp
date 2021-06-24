import '../post_a_job/Category.dart';
import '../User.dart';

class ProfessionalResponse {
  final bool success;
  final Professional data;

  ProfessionalResponse({this.success, this.data});

  factory ProfessionalResponse.fromJson(Map<String, dynamic> json) => ProfessionalResponse(
    success: json["success"],
    data: Professional.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Professional": data != null ? data.toJson() : null,
    "success": success,
  };
}

class Professional {
  final int proId;
  final int addressId;
  final int categoryId;
  final String dob;
  final String gender;
  final String introduction;
  final String phone;
  final int price;
  final String skills;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  Address address;
  Category category;

  Professional({
    this.proId,
    this.addressId,
    this.categoryId,
    this.dob,
    this.gender,
    this.introduction,
    this.phone,
    this.price,
    this.skills,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.category,
  });

  factory Professional.fromJson(Map<String, dynamic> json) => Professional(
    addressId: json["addressId"],
    categoryId: json["categoryId"],
    dob: json["dob"],
    gender: json["gender"],
    introduction: json["introduction"],
    phone: json["phone"],
    price: json["price"],
    proId: json["proId"],
    skills: json["skills"],
    title: json["title"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    address: Address.fromJson(json["address"]),
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "proId": proId,
    "addressId": addressId,
    "categoryId": categoryId,
    "dob": dob,
    "gender": gender,
    "introduction": introduction,
    "phone": phone,
    "price": price,
    "skills": skills,
    "title": title,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "address": address != null ? address.toJson() : null,
    "category": category != null ? category.toJson() : null,
  };
}

class ProfessionalRequest {
  Address address;
  int categoryId;
  String categoryName;
  String title;
  String gender;
  String phone;
  String dob;
  String skills;
  String introduction;
  double price;
  User user;

  ProfessionalRequest({
    this.address,
    this.categoryId,
    this.categoryName,
    this.dob,
    this.gender,
    this.introduction,
    this.phone,
    this.price,
    this.skills,
    this.title,
    this.user,
  });

  factory ProfessionalRequest.fromJson(Map<String, dynamic> json) => ProfessionalRequest(
    address: Address.fromJson(json["address"]),
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    dob: json["dob"],
    gender: json["gender"],
    introduction: json["introduction"],
    phone: json["phone"],
    price: json["price"],
    skills: json["skills"],
    title: json["title"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "address": address != null ? address.toJson() : null,
      "categoryId": categoryId != null ? categoryId : null,
      "categoryName": categoryName != null ? categoryName : null,
      "dob": dob != null ? dob : null,
      "gender": gender != null ? gender : null,
      "introduction": introduction != null ? introduction : null,
      "phone": phone != null ? phone : null,
      "price": price != null ? price : null,
      "skills": skills != null ? skills : null,
      "title": title != null ? title : null,
      "user": user != null ? user.toJson() : null,
    };
    return map;
  }
}