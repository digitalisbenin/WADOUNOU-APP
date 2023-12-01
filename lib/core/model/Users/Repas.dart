import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'Repas.g.dart';

Repas repasFromJson(String str) => Repas.fromJson(json.decode(str));

String repasToJson(Repas data) => json.encode(data.toJson());

class RepasModel {
  List<Repas> repas;

  RepasModel({
    required this.repas,
  });

  factory RepasModel.fromJson(Map<String, dynamic> json) => RepasModel(
    repas: List<Repas>.from(json["repas"].map((x) => Repas.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "repas": List<dynamic>.from(repas.map((x) => x.toJson())),
  };
}

@JsonSerializable()
class Repas {
  String? id;
  String? name;
  String? description;
  String? prix;
  String? image_url;


  Repas({
    this.id,
    this.name,
    this.description,
    this.prix,
    this.image_url,
  });

  factory Repas.fromJson(Map<String, dynamic> json) {
    return Repas(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      prix: json['prix'],
      image_url: json['image_url'],
    );
  }

  /* factory Repas.fromJson(Map<String, dynamic> json) => _$RepasFromJson(json); */

  Map<String, dynamic> toJson() => _$RepasToJson(this);
}
