import 'package:json_annotation/json_annotation.dart';

part 'Commentaires.g.dart';

@JsonSerializable()
class Commentaires {
  Commentaires();

  @JsonKey(required: true)
  int? id;
  @JsonKey(name: 'repas_id')
  int? repas_id;
  String? content;
  @JsonKey(name: 'created_at')
  late DateTime created_at = DateTime.timestamp();
  @JsonKey(name: 'update_at')
  late DateTime update_at = DateTime.timestamp();

  factory Commentaires.fromJson(Map<String, dynamic> json) =>
      _$CommentairesFromJson(json);

  Map<String, dynamic> toJson() => _$CommentairesToJson(this);
}
