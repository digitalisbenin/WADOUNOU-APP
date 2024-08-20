
import 'dart:convert';

Specialite specialiteFromJson(String str) => Specialite.fromJson(json.decode(str));

String specialiteToJson(Specialite data) => json.encode(data.toJson());

class Specialite {
  List<SpecialiteModel> data;

  Specialite({
    required this.data,
  });

  factory Specialite.fromJson(Map<String, dynamic> json) => Specialite(
    data: List<SpecialiteModel>.from(json["data"].map((x) => SpecialiteModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SpecialiteModel {
  String id;
  String name;
  dynamic description;

  SpecialiteModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory SpecialiteModel.fromJson(Map<String, dynamic> json) => SpecialiteModel(
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
