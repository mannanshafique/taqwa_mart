// To parse this JSON data, do
//
//     final deliveryTimeModel = deliveryTimeModelFromJson(jsonString);

import 'dart:convert';

DeliveryTimeModel deliveryTimeModelFromJson(String str) => DeliveryTimeModel.fromJson(json.decode(str));

String deliveryTimeModelToJson(DeliveryTimeModel data) => json.encode(data.toJson());

class DeliveryTimeModel {
    DeliveryTimeModel({
      required  this.code,
      required  this.data,
      required  this.message,
    });

    final Data data;
    final int code;
    final String message;

    factory DeliveryTimeModel.fromJson(Map<String, dynamic> json) => DeliveryTimeModel(
        data: Data.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "code": code,
        "message": message,
    };
}

class Data {
    Data({
      required  this.delieveryTimes,
    });

    final List<DelieveryTime> delieveryTimes;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        delieveryTimes: List<DelieveryTime>.from(json["DelieveryTimes"].map((x) => DelieveryTime.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "DelieveryTimes": List<dynamic>.from(delieveryTimes.map((x) => x.toJson())),
    };
}

class DelieveryTime {
    DelieveryTime({
      required  this.id,
      required  this.times,
      required  this.createdAt,
       required this.updatedAt,
      required  this.status,
    });

    final int id;
    final String times;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int status;

    factory DelieveryTime.fromJson(Map<String, dynamic> json) => DelieveryTime(
        id: json["id"],
        times: json["times"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "times": times,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
    };
}
