// To parse this JSON data, do
//
//     final nestedCategory = nestedCategoryFromJson(jsonString);

import 'dart:convert';

NestedCategory nestedCategoryFromJson(String str) => NestedCategory.fromJson(json.decode(str));

String nestedCategoryToJson(NestedCategory data) => json.encode(data.toJson());

class NestedCategory {
    NestedCategory({
        required this.categories,
        required this.result,
        required this.statusCode,
    });

    Categories categories;
    String result;
    int statusCode;

    factory NestedCategory.fromJson(Map<String, dynamic> json) => NestedCategory(
        categories: Categories.fromJson(json["Categories"]),
        result: json["Result"],
        statusCode: json["StatusCode"],
    );

    Map<String, dynamic> toJson() => {
        "Categories": categories.toJson(),
        "Result": result,
        "StatusCode": statusCode,
    };
}

class Categories {
    Categories({
        required this.id,
        required this.name,
        required this.pid,
        required this.childrenRecursive,
    });

    int id;
    String name;
    int pid;
    List<ChildrenRecursive> childrenRecursive;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        pid: json["pid"],
        childrenRecursive: List<ChildrenRecursive>.from(json["children_recursive"].map((x) => ChildrenRecursive.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pid": pid,
        "children_recursive": List<dynamic>.from(childrenRecursive.map((x) => x.toJson())),
    };
}

class ChildrenRecursive {
    ChildrenRecursive({
        required this.id,
        required this.name,
        required this.pid,
         this.status,
         this.createdAt,
         this.updatedAt,
        required this.image,
         this.sort,
         this.childrenRecursive,
    });

    int id;
    String name;
    int pid;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic image;
    dynamic sort;
    List? childrenRecursive;

    factory ChildrenRecursive.fromJson(Map<String, dynamic> json) => ChildrenRecursive(
        id: json["id"],
        name: json["name"],
        pid: json["pid"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        sort: json["sort"],
        childrenRecursive: List.from(json["children_recursive"].map((x) => ChildrenRecursive.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pid": pid,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "image": image,
        "sort": sort,
        "children_recursive": List<dynamic>.from(childrenRecursive!.map((x) => x.toJson())),
    };
}
