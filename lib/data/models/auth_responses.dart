// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Authentication authenticationFromJson(String str) =>
    Authentication.fromJson(json.decode(str));

class Authentication {
  User? data;
  bool? success;
  String? message;

  Authentication({
    this.data,
    this.success,
    this.message,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        data: json["data"] == null ? null : User.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );
}

class User {
  String? token;
  int? id;
  String? email;
  String? contact;
  dynamic image;

  User({
    this.token,
    this.id,
    this.email,
    this.contact,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        id: json["id"],
        email: json["email"],
        contact: json["contact"],
        image: json["image"],
      );
}
