// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Abonnements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Abonnements _$AbonnementsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return Abonnements()
    ..id = json['id'] as int?
    ..name = json['name'] as String?
    ..description = json['description'] as String?
    ..created_at = DateTime.parse(json['created_at'] as String)
    ..update_at = DateTime.parse(json['update_at'] as String);
}

Map<String, dynamic> _$AbonnementsToJson(Abonnements instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.created_at.toIso8601String(),
      'update_at': instance.update_at.toIso8601String(),
    };
