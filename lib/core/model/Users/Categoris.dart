// To parse this JSON data, do
//
//     final categorisModel = categorisModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'Categoris.g.dart';

CategorisModel categorisModelFromJson(String str) => CategorisModel.fromJson(json.decode(str));

String categorisModelToJson(CategorisModel data) => json.encode(data.toJson());

class CategorisModel {
    List<Categoris> categoris;

    CategorisModel({
        required this.categoris,
    });

    factory CategorisModel.fromJson(Map<String, dynamic> json) => CategorisModel(
        categoris: List<Categoris>.from(json["categoris"].map((x) => Categoris.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categoris": List<dynamic>.from(categoris.map((x) => x.toJson())),
    };
}

@JsonSerializable()
class Categoris {
    String? id;
    String? name;
    String? description;

    Categoris({
        this.id,
        this.name,
        this.description,
    });

    factory Categoris.fromJson(Map<String, dynamic> json) {
    return Categoris(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

/* factory Categoris.fromJson(Map<String, dynamic> json) => _$CategorisFromJson(json); */

   /*  factory Categoris.fromJson(Map<String, dynamic> json) => Categoris(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        description: descriptionValues.map[json["description"]]!,
    ); */

    Map<String, dynamic> toJson() => _$CategorisToJson(this);

    /* Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "description": descriptionValues.reverse[description],
    }; */
}