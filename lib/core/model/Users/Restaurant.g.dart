// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      adresse: json['adresse'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      specilite: json['specilite'] as String?,
      menu: json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
      heure_douverture: json['heure_douverture'] as String?,
      heure_fermeture: json['heure_fermeture'] as String?,
      document_url: json['document_url'] as String?,
      capacite: json['capacite'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adresse': instance.adresse,
      'phone': instance.phone,
      'description': instance.description,
      'specilite': instance.specilite,
      'menu': instance.menu,
      'heure_douverture': instance.heure_douverture,
      'heure_fermeture': instance.heure_fermeture,
      'document_url': instance.document_url,
      'capacite': instance.capacite,
      'image_url': instance.image_url,
    };
