class PopularService {
  int popularServiceId;
  String description;
  String imagePath;
  String popularServiceName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  PopularService({
    this.popularServiceId,
    this.description,
    this.imagePath,
    this.popularServiceName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PopularService.fromJson(Map<String, dynamic> json) => PopularService(
    popularServiceId: json["popularServiceId"],
    description: json["description"],
    imagePath: json["imagePath"],
    popularServiceName: json["popularServiceName"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "popularServiceId": popularServiceId,
    "description": description,
    "imagePath": imagePath,
    "popularServiceName": popularServiceName,
    "createdAt": createdAt != null ? createdAt : null,
    "updatedAt": updatedAt != null ? updatedAt : null,
    "deletedAt": deletedAt != null ? deletedAt : null,
  };
}

class PopularServiceResponse {
  final bool success;
  final List<PopularService> data;

  PopularServiceResponse({this.success, this.data});

  factory PopularServiceResponse.fromJson(Map<String, dynamic> json) => PopularServiceResponse(
    success: json["success"],
    data: List<PopularService>.from(json["data"].map((x) => PopularService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}