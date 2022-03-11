// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.products,
    required this.result,
    required this.statusCode,
  });

  List<Product> products;
  String result;
  int statusCode;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        result: json["Result"],
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "Result": result,
        "StatusCode": statusCode,
      };
}

class Product {
  Product({
    required this.id,
    required this.catId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.discription,
    required this.productAttributes,
  });

  int id;
  int catId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String discription;
  List<ProductAttribute> productAttributes;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        catId: json["cat_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        discription: json["discription"]??'',
        productAttributes: List<ProductAttribute>.from(
            json["product_attributes"]
                .map((x) => ProductAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "discription": discription,
        "product_attributes":
            List<dynamic>.from(productAttributes.map((x) => x.toJson())),
      };
}

class ProductAttribute {
  ProductAttribute({
    required this.id,
    required this.prodId,
    required this.image,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.stock,
    required this.size,
    required this.sizeType,
  });

  int id;
  int prodId;
  String image;
  int price;
  int stock;
  int size;
  int discountPrice;
  int discountPercentage;
  String sizeType;

  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      ProductAttribute(
        id: json["id"],
        prodId: json["prod_id"],
        image: json["image"],
        price: json["price_retail"],
        stock: json["stock"],
        size: json["size"],
        discountPercentage: json['discount_percent']??0,
        discountPrice: json['price_discount']??0,
        sizeType: json["size_type"] == null ?'unit' : json["size_type"]['type'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prod_id": prodId,
        "image": image,
        "price": price,
        "stock": stock,
        "size": size,
        "discount_percent" : discountPercentage,
        "price_discount" : discountPrice,
        "size_type": sizeType,
      };
}

// class SizeType {
//     SizeType({
//       required  this.id,
//       required  this.type,
//       required  this.createdAt,
//       required  this.updatedAt,
//     });

//     int id;
//     String type;
//     dynamic createdAt;
//     dynamic updatedAt;

//     factory SizeType.fromJson(Map<String, dynamic> json) => SizeType(
//         id: json["id"],
//         type: json["type"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }
