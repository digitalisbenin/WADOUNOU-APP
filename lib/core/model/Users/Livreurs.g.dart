// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Livreurs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Livreurs _$LivreursFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return Livreurs()
    ..id = json['id'] as int?
    ..restaurant_id = json['restaurant_id'] as int?
    ..user_id = json['user_id'] as int?
    ..name = json['name'] as String?
    ..description = json['description'] as String?
    ..addrese = json['addrese'] as String?
    ..phone = json['phone'] as String?
    ..created_at = DateTime.parse(json['created_at'] as String)
    ..update_at = DateTime.parse(json['update_at'] as String);
}

Map<String, dynamic> _$LivreursToJson(Livreurs instance) => <String, dynamic>{
      'id': instance.id,
      'restaurant_id': instance.restaurant_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'description': instance.description,
      'addrese': instance.addrese,
      'phone': instance.phone,
      'created_at': instance.created_at.toIso8601String(),
      'update_at': instance.update_at.toIso8601String(),
    };
