// To parse this JSON data, do
//
//     final LivreurInfoModel = LivreurInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:digitalis_restaurant_app/core/model/Users/User.dart';

LivreurInfoModel LivreurInfoModelFromJson(String str) => LivreurInfoModel.fromJson(json.decode(str));

String LivreurInfoModelToJson(LivreurInfoModel data) => json.encode(data.toJson());

class LivreurInfoModel {
  List<LivreurInfo> data;

  LivreurInfoModel({
    required this.data,
  });

  factory LivreurInfoModel.fromJson(Map<String, dynamic> json) => LivreurInfoModel(
    data: List<LivreurInfo>.from(json["data"].map((x) => LivreurInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LivreurInfo {
  String id;
  String name;
  String adresse;
  String phone;
  String description;
  String position;
  String imageUrl;
  String documentUrl;
  String status;
  Users user;

  LivreurInfo({
    required this.id,
    required this.name,
    required this.adresse,
    required this.phone,
    required this.description,
    required this.position,
    required this.imageUrl,
    required this.documentUrl,
    required this.status,
    required this.user,
  });

  factory LivreurInfo.fromJson(Map<String, dynamic> json) => LivreurInfo(
    id: json["id"],
    name: json["name"],
    adresse: json["adresse"],
    phone: json["phone"],
    description: json["description"],
    position: json["position"],
    imageUrl: json["image_url"],
    documentUrl: json["document_url"],
    status: json["status"],
    user: Users.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "adresse": adresse,
    "phone": phone,
    "description": description,
    "position": position,
    "image_url": imageUrl,
    "document_url": documentUrl,
    "status": status,
    "user": user.toJson(),
  };
}