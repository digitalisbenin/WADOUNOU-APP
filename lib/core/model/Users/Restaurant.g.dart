// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      heure_douverture: json['heure_douverture'] as String,
      heure_fermeture: json['heure_fermeture'] as String,
      specialite: json['specialite'] as String,
      adresse: json['adresse'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      mtnpay: json['mtnpay'] as String,
      moovpay: json['moovpay'] as String,
      celtispay: json['celtispay'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adresse': instance.adresse,
      'specialite': instance.specialite,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'heure_douverture': instance.heure_douverture,
      'heure_fermeture': instance.heure_fermeture,
      'mtnpay': instance.mtnpay,
      'moovpay': instance.moovpay,
      'celtispay': instance.celtispay,
    };
