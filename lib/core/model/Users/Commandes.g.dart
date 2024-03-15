// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Commandes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commandes _$CommandesFromJson(Map<String, dynamic> json) => Commandes(
      id: json['id'] as String?,
      name: json['name'] as String?,
      adresse: json['adresse'] as String?,
      contact: json['contact'] as String?,
      status: json['status'] as String?,
      repasId: json['repasId'] as String?,
      montant: json['montant'] as String?,
      quantite: json['quantite'] as String?,
    );

Map<String, dynamic> _$CommandesToJson(Commandes instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adresse': instance.adresse,
      'contact': instance.contact,
      'status': instance.status,
      'repasId': instance.repasId,
      'montant': instance.montant,
      'quantite': instance.quantite,
    };
