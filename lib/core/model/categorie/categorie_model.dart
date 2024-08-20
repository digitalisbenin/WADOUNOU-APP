// To parse this JSON data, do
//
//     final categorie = categorieFromJson(jsonString);

import 'dart:convert';

Categorie categorieFromJson(String str) => Categorie.fromJson(json.decode(str));

String categorieToJson(Categorie data) => json.encode(data.toJson());

class Categorie {
  List<CategorieModel> data;

  Categorie({
    required this.data,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
    data: List<CategorieModel>.from(json["data"].map((x) => CategorieModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategorieModel {
  String id;
  String name;
  dynamic description;

  CategorieModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
