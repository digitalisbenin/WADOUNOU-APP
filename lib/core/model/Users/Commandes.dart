
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'Commandes.g.dart';

Commandes commandesFromJson(String str) => Commandes.fromJson(json.decode(str));

String commandesToJson(Commandes commandes) => json.encode(commandes.toJson());

@JsonSerializable()
class Commandes {
  String? id;
  String? name;
  String? adresse;
  String? contact;
  String? status;
  String? repasId;
  String? montant;
  String? quantite;

  Commandes({
    this.id,
    this.name,
    this.adresse,
    this.contact,
    this.status,
    this.repasId,
    this.montant,
    this.quantite,
  });

  factory Commandes.fromJson(Map<String, dynamic> json) => _$CommandesFromJson(json);

  Map<String, dynamic> toJson() => _$CommandesToJson(this);
}
