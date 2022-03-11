// To parse this JSON data, do
//
//     final b2BProductModel = b2BProductModelFromJson(jsonString);

import 'dart:convert';

B2BProductModel b2BProductModelFromJson(String str) => B2BProductModel.fromJson(json.decode(str));

String b2BProductModelToJson(B2BProductModel data) => json.encode(data.toJson());

class B2BProductModel {
    B2BProductModel({
       required this.products,
       required this.result,
       required this.statusCode,
    });

    List<B2BProduct> products;
    String result;
    int statusCode;

    factory B2BProductModel.fromJson(Map<String, dynamic> json) => B2BProductModel(
        products: List<B2BProduct>.from(json["products"].map((x) => B2BProduct.fromJson(x))),
        result: json["Result"],
        statusCode: json["StatusCode"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "Result": result,
        "StatusCode": statusCode,
    };
}

class B2BProduct {
    B2BProduct({
       required this.id,
       required this.name,
       required this.discription,
       required this.priceRetail,
       required this.priceDiscount,
       required this.unit,
       required this.unitTypeId,
       required this.stock,
       required this.status,
       required this.catId,
       required this.image,
       required this.discountPercent,
       required this.unitType,
    });

    int id;
    String name;
    String discription;
    int priceRetail;
    int priceDiscount;
    int discountPercent;
    int unit;
    int unitTypeId;
    int stock;
    int status;
    int catId;
    String image;
    String unitType;

    factory B2BProduct.fromJson(Map<String, dynamic> json) => B2BProduct(
        id: json["id"],
        name: json["name"],
        discountPercent: json["discount_percent"],
        discription: json["discription"],
        priceRetail: json["price_retail"],
        priceDiscount: json["price_discount"],
        unit: json["unit"],
        unitTypeId: json["unit_type_id"],
        stock: json["stock"],
        status: json["status"],
        catId: json["cat_id"],
        image: json["image"],
        unitType: json["unit_type"]["name"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discription": discription,
        "price_retail": priceRetail,
        "price_discount": priceDiscount,
        "discount_percent" : discountPercent,
        "unit": unit,
        "unit_type_id": unitTypeId,
        "stock": stock,
        "status": status,
        "cat_id": catId,
        "image": image,
        "unit_type": unitType,
    };
}


