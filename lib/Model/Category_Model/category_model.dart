
// import 'dart:convert';

// CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

// String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

// class CategoryModel {
//     CategoryModel({
//         required this.categories,
//         required this.result,
//         required this.statusCode,
//     });

//     List<Category> categories;
//     String result;
//     int statusCode;

//     factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//         categories: List<Category>.from(json["Categories"].map((x) => Category.fromJson(x))),
//         result: json["Result"],
//         statusCode: json["StatusCode"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//         "Result": result,
//         "StatusCode": statusCode,
//     };
// }

// class Category {
//     Category({
//       required  this.id,
//       required  this.name,
//       required  this.pid,
//       required  this.image,
//     });

//     int id;
//     String name;
//     int pid;
//     String image;

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         pid: json["pid"],
//         image: json["image"]
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "pid": pid,
//         "image":image
//     };
// }
// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    CategoryModel({
         required this.categories,
         required this.result,
         required this.statusCode,
    });

    final List<Category> categories;
    final String result;
    final int statusCode;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(json["Categories"].map((x) => Category.fromJson(x))),
        result: json["Result"],
        statusCode: json["StatusCode"],
    );

    Map<String, dynamic> toJson() => {
        "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "Result": result,
        "StatusCode": statusCode,
    };
}

class Category {
    Category({
         required this.id,
         required this.name,
         required this.pid,
         required this.image,
        required this.categoryFirstChildern,
    });

    final int id;
    final String name;
    final int pid;
    final String image;
    final List<CategoryFirstChild> categoryFirstChildern;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        pid: json["pid"],
        image: json["image"],
        categoryFirstChildern: List<CategoryFirstChild>.from(json["children"].map((x) => CategoryFirstChild.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pid": pid,
        "image": image,
        "children": List<dynamic>.from(categoryFirstChildern.map((x) => x.toJson())),
    };
}

class CategoryFirstChild {
    CategoryFirstChild({
         required this.id,
         required this.name,
         required this.pid,
         required this.status,
         required this.createdAt,
         required this.updatedAt,
         required this.image,
         required this.sort,
    });

    final int id;
    final String name;
    final int pid;
    final int status;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String image;
    final dynamic sort;

    factory CategoryFirstChild.fromJson(Map<String, dynamic> json) => CategoryFirstChild(
        id: json["id"],
        name: json["name"],
        pid: json["pid"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"] == null ? '' : json["image"],
        sort: json["sort"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pid": pid,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image == null ? null : image,
        "sort": sort,
    };
}
