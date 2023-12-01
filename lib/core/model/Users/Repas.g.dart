// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Repas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repas _$RepasFromJson(Map<String, dynamic> json) => Repas(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      prix: json['prix'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$RepasToJson(Repas instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'prix': instance.prix,
      'image_url': instance.image_url,
    };
