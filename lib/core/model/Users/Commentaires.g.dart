// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Commentaires.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commentaires _$CommentairesFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return Commentaires()
    ..id = json['id'] as int?
    ..repas_id = json['repas_id'] as int?
    ..content = json['content'] as String?
    ..created_at = DateTime.parse(json['created_at'] as String)
    ..update_at = DateTime.parse(json['update_at'] as String);
}

Map<String, dynamic> _$CommentairesToJson(Commentaires instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repas_id': instance.repas_id,
      'content': instance.content,
      'created_at': instance.created_at.toIso8601String(),
      'update_at': instance.update_at.toIso8601String(),
    };
