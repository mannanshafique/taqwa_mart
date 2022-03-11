// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    UserProfileModel({
     required   this.result,
     required   this.statusCode,
      required  this.user,
    });

    final String result;
    final int statusCode;
    final User user;

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        result: json["Result"],
        statusCode: json["StatusCode"],
        user: User.fromJson(json["User"]),
    );

    Map<String, dynamic> toJson() => {
        "Result": result,
        "StatusCode": statusCode,
        "User": user.toJson(),
    };
}

class User {
    User({
      required  this.id,
      required  this.name,
      required  this.email,
      required  this.emailVerifiedAt,
      required  this.phone,
      required  this.createdAt,
      required  this.updatedAt,
      required  this.avatar,
      required  this.firstName,
      required  this.lastName,
      required  this.userType,
      required  this.address,
      required  this.status,
    });

    final int id;
    final String name;
    final String email;
    final dynamic emailVerifiedAt;
    final String phone;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String avatar;
    final String firstName;
    final String lastName;
    final int userType;
    final dynamic address;
    final int status;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userType: json["user_type"],
        address: json["address"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "avatar": avatar,
        "first_name": firstName,
        "last_name": lastName,
        "user_type": userType,
        "address": address,
        "status": status,
    };
}
