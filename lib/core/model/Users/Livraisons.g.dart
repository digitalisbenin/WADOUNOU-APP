// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Livraisons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Livraisons _$LivraisonsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return Livraisons()
    ..id = json['id'] as int?
    ..commande_id = json['commande_id'] as int?
    ..livreur_id = json['livreur_id'] as int?
    ..name = json['name'] as String?
    ..description = json['description'] as String?
    ..addrese = json['addrese'] as String?
    ..phone = json['phone'] as String?
    ..status = json['status'] as String?
    ..created_at = DateTime.parse(json['created_at'] as String)
    ..update_at = DateTime.parse(json['update_at'] as String);
}

Map<String, dynamic> _$LivraisonsToJson(Livraisons instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commande_id': instance.commande_id,
      'livreur_id': instance.livreur_id,
      'name': instance.name,
      'description': instance.description,
      'addrese': instance.addrese,
      'phone': instance.phone,
      'status': instance.status,
      'created_at': instance.created_at.toIso8601String(),
      'update_at': instance.update_at.toIso8601String(),
    };
