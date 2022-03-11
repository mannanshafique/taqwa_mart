// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.notifications,
    required this.result,
    required this.statusCode,
  });

  final List<Notification> notifications;
  final String result;
  final int statusCode;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notifications: List<Notification>.from(
            json["Notifications"].map((x) => Notification.fromJson(x))),
        result: json["Result"],
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "Result": result,
        "StatusCode": statusCode,
      };
}

class Notification {
  Notification({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.to,
    required this.from,
    required this.message,
    required this.readAt,
    required this.resend,
    required this.user,
  });

  final int id;
  final String createdAt;
  final DateTime updatedAt;
  final String to;
  final String from;
  final String message;
  final dynamic readAt;
  final dynamic resend;
  final String user;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        createdAt: DateFormat('dd-MM-yyyy / h m a')
            .format(DateTime.parse(json["created_at"]))
            .toString(),
        updatedAt: DateTime.parse(json["updated_at"]),
        to: json["to"],
        from: json["from"],
        message: json["message"],
        readAt: json["read_at"],
        resend: json["resend"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "to": to,
        "from": from,
        "message": message,
        "read_at": readAt,
        "resend": resend,
        "user": user,
      };
}
