// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      prix: json['prix'] as String?,
      repasList: (json['repasList'] as List<dynamic>?)
          ?.map((e) => Repas.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'prix': instance.prix,
      'repasList': instance.repasList,
    };
