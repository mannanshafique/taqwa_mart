

import 'dart:convert';

ListingModel listingModelFromJson(String str) => ListingModel.fromJson(json.decode(str));

String listingModelToJson(ListingModel data) => json.encode(data.toJson());

class ListingModel {
    ListingModel({
       required this.result,
       required this.statusCode,
    });

    List<ListRbd> result;
    int statusCode;

    factory ListingModel.fromJson(Map<String, dynamic> json) => ListingModel(
        result: List<ListRbd>.from(json["Result"].map((x) => ListRbd.fromJson(x))),
        statusCode: json["StatusCode"],
    );

    Map<String, dynamic> toJson() => {
        "Result": List<dynamic>.from(result.map((x) => x.toJson())),
        "StatusCode": statusCode,
    };
}

class ListRbd {
    ListRbd({
      required  this.brand,
      required  this.rate,
    });

    String brand;
    String rate;

    factory ListRbd.fromJson(Map<String, dynamic> json) => ListRbd(
        brand: json["brand"],
        rate: json["rate"],
    );

    Map<String, dynamic> toJson() => {
        "brand": brand,
        "rate": rate,
    };
}







