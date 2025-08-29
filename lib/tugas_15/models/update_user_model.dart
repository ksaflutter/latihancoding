import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));
String updateUserModelToJson(UpdateUserModel data) =>
    json.encode(data.toJson());

class UpdateUserModel {
  String? message;
  Data? data;
  UpdateUserModel({this.message, this.data});
  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
