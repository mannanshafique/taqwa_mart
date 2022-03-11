// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    required this.orderHistory,
    required this.result,
    required this.statusCode,
  });

  final List<OrderHistory> orderHistory;
  final String result;
  final int statusCode;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        orderHistory: List<OrderHistory>.from(
            json["OrderHistory"].map((x) => OrderHistory.fromJson(x))),
        result: json["Result"],
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "OrderHistory": List<dynamic>.from(orderHistory.map((x) => x.toJson())),
        "Result": result,
        "StatusCode": statusCode,
      };
}

class OrderHistory {
  OrderHistory({
    required this.id,
    required this.orderNo,
    required this.userId,
    required this.deliveryCharges,
    required this.totalAmount,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.status,
    required this.cancellAt,
    required this.orderDetail,
  });

  final int id;
  final String orderNo;
  final int userId;
  final String deliveryCharges;
  final String totalAmount;
  final String phone;
  final String address;
  final DateTime createdAt;
  final String cancellAt;
  final int status;
  final List<OrderDetail> orderDetail;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        id: json["id"],
        orderNo: json["order_no"],
        userId: json["user_id"],
        deliveryCharges: json["delivery_charges"],
        totalAmount: json["total_amount"],
        phone: json["phone"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        // DateFormat('dd-MM-yy ( h:m:a )')
        //     .format(DateTime.parse(json["created_at"]))
        //     .toString(),
        cancellAt: json["cancel_at"] == null
            ? ''
            : DateFormat('dd-MM-yy ( h:m:a )')
                .format(DateTime.parse(json["cancel_at"]))
                .toString(),
        // DateTime.parse(json["created_at"]),
        status: json["status"],
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "user_id": userId,
        "delivery_charges": deliveryCharges,
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
    required this.name,
    required this.discription,
    required this.image,
    required this.priceRetail,
    required this.priceDiscount,
    required this.unit,
    required this.unitTypeId,
    required this.catId,
    required this.stock,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.discountPercent,
    required this.nameUrdu,
    required this.discriptionUrdu,
    required this.unitType,
  });

  final int id;
  final String name;
  final String discription;
  final String image;
  final int priceRetail;
  final int priceDiscount;
  final int unit;
  final int unitTypeId;
  final int catId;
  final int stock;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int discountPercent;
  final String nameUrdu;
  final String discriptionUrdu;
  final String unitType;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        name: json["name"],
        discription: json["discription"],
        image: json["image"],
        priceRetail: json["price_retail"],
        priceDiscount: json["price_discount"],
        unit: json["unit"],
        unitTypeId: json["unit_type_id"],
        catId: json["cat_id"],
        stock: json["stock"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        discountPercent: json["discount_percent"],
        nameUrdu: json["name_urdu"],
        discriptionUrdu:
            json["discription_urdu"] == null ? '' : json["discription_urdu"],
        unitType: json["unit_type"]['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discription": discription,
        "image": image,
        "price_retail": priceRetail,
        "price_discount": priceDiscount,
        "unit": unit,
        "unit_type_id": unitTypeId,
        "cat_id": catId,
        "stock": stock,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "discount_percent": discountPercent,
        "name_urdu": nameUrdu,
        "discription_urdu": discriptionUrdu == null ? '' : discriptionUrdu,
        "unit_type": unitType,
      };
}
