// To parse this JSON data, do
//
//     final b2COrderHistoryModel = b2COrderHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

B2COrderHistoryModel b2COrderHistoryModelFromJson(String str) =>
    B2COrderHistoryModel.fromJson(json.decode(str));

String b2COrderHistoryModelToJson(B2COrderHistoryModel data) =>
    json.encode(data.toJson());

class B2COrderHistoryModel {
  B2COrderHistoryModel({
    required this.orderHistory,
    required this.result,
    required this.statusCode,
  });

  final List<B2COrderHistory> orderHistory;
  final String result;
  final int statusCode;

  factory B2COrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      B2COrderHistoryModel(
        orderHistory: List<B2COrderHistory>.from(
            json["OrderHistory"].map((x) => B2COrderHistory.fromJson(x))),
        result: json["Result"],
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "OrderHistory": List<dynamic>.from(orderHistory.map((x) => x.toJson())),
        "Result": result,
        "StatusCode": statusCode,
      };
}

class B2COrderHistory {
  B2COrderHistory({
    required this.id,
    required this.orderNo,
    required this.userId,
    required this.deliveryCharges,
    required this.deliveryTime,
    required this.totalAmount,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.status,
    required this.cancelAt,
    required this.orderDetail,
  });

  final int id;
  final String orderNo;
  final int userId;
  final String deliveryTime;
  final String deliveryCharges;
  final String totalAmount;
  final String phone;
  final String address;
  final DateTime createdAt;
  final String cancelAt;
  final int status;
  final List<OrderDetail> orderDetail;

  factory B2COrderHistory.fromJson(Map<String, dynamic> json) =>
      B2COrderHistory(
        id: json["id"],
        orderNo: json["order_no"],
        userId: int.parse(json["user_id"]),
        deliveryCharges: json['delivery_charges'],
        deliveryTime: json['delivery_time'],
        totalAmount: json["total_amount"],
        phone: json["phone"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        cancelAt:json["cancel_at"] == null ? '' : DateFormat('dd-MM-yy ( h:m:a )')
                .format(DateTime.parse(json["cancel_at"]))
                .toString(),
        status: json["status"],
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "user_id": userId,
        "total_amount": totalAmount,
        "phone": phone,
        "address": address,
        "created_at": createdAt,
        "status": status,
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    required this.id,
    required this.productId,
    required this.orderNo,
    required this.quantity,
    required this.amount,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.productDetail,
  });

  final int id;
  final int productId;
  final String orderNo;
  final String quantity;
  final String amount;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductDetail productDetail;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        productId: json["product_id"],
        orderNo: json["order_no"],
        quantity: json["quantity"],
        amount: json["amount"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productDetail: ProductDetail.fromJson(json["product_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "order_no": orderNo,
        "quantity": quantity,
        "amount": amount,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_detail": productDetail.toJson(),
      };
}

class ProductDetail {
  ProductDetail({
    required this.id,
    required this.prodId,
    required this.image,
    required this.priceRetail,
    required this.stock,
    required this.size,
    required this.sizeType,
    required this.createdAt,
    required this.updatedAt,
    required this.priceDiscount,
    required this.discountPercent,
    required this.product,
  });

  final int id;
  final int prodId;
  final String image;
  final int priceRetail;
  final int stock;
  final int size;
  final String sizeType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int priceDiscount;
  final int discountPercent;
  final Product product;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        prodId: json["prod_id"],
        image: json["image"],
        priceRetail: json["price_retail"],
        stock: json["stock"],
        size: json["size"],
        sizeType: json["size_type"]['type'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        priceDiscount: json["price_discount"] ?? 0,
        discountPercent: json["discount_percent"] ?? 0,
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prod_id": prodId,
        "image": image,
        "price_retail": priceRetail,
        "stock": stock,
        "size": size,
        "size_type": sizeType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "price_discount": priceDiscount,
        "discount_percent": discountPercent,
        "product": product.toJson(),
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
  });

  final int id;
  final int catId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String discription;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        catId: json["cat_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        discription: json["discription"] == null ? '' : json["discription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "discription": discription,
      };
}
