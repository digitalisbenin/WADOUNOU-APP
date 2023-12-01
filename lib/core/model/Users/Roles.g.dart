// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Roles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Roles _$RolesFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return Roles()
    ..id = json['id'] as int?
    ..name = json['name'] as String?
    ..created_at = DateTime.parse(json['created_at'] as String)
    ..update_at = DateTime.parse(json['update_at'] as String);
}

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.created_at.toIso8601String(),
      'update_at': instance.update_at.toIso8601String(),
    };
