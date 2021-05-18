class CategoryResponse {
  final bool success;
  final List<Category> data;

  CategoryResponse({this.success, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    success: json["success"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  final int categoryId;
  final String categoryName;
  final dynamic createdAt;
  final dynamic deletedAt;
  final String description;
  final String imagePath;
  final dynamic updatedAt;

  Category({
    this.categoryId,
    this.categoryName,
    this.createdAt,
    this.deletedAt,
    this.description,
    this.imagePath,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    createdAt: json["createdAt"],
    deletedAt: json["deletedAt"],
    description: json["description"],
    imagePath: json["imagePath"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "createdAt": createdAt,
    "deletedAt": deletedAt,
    "description": description,
    "imagePath": imagePath,
    "updatedAt": updatedAt,
  };
}

class TaskDetails {
  String taskTitle;
  String taskDescription;
  String taskPrice;

  TaskDetails({this.taskTitle, this.taskDescription, this.taskPrice});

  Map<String, dynamic> toJson() {
    try {
      Map<String, dynamic> map = {
        "taskTitle": taskTitle,
        "taskDescription": taskDescription,
        "taskPrice": taskPrice,
      };
      return map;
    } catch(e) {
      print("cm $e");
      return null;
    }
  }
}

class Address {
  String street;
  String city;
  dynamic pincode;
  String country;

  Address({this.street, this.city, this.pincode, this.country});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    city: json["city"],
    pincode: json["pincode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() {
    try {
      Map<String, dynamic> map = {
        "street": street != null ? street : null,
        "city": city != null ? city : null,
        "pincode": pincode != null ? pincode : null,
        "country": country != null ? country : null,
      };
      return map;
    } catch(e) {
      print("cm $e");
      return null;
    }
  }
}