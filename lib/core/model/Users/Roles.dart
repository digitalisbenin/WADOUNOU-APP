import 'package:json_annotation/json_annotation.dart';

part 'Roles.g.dart';

@JsonSerializable()
class Roles {
  Roles();

  @JsonKey(required: true)
  int? id;
  String? name;
  @JsonKey(name: 'created_at')
  late DateTime created_at = DateTime.timestamp();
  @JsonKey(name: 'update_at')
  late DateTime update_at = DateTime.timestamp();

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}
