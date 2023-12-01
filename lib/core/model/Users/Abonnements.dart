import 'package:json_annotation/json_annotation.dart';

part 'Abonnements.g.dart';

@JsonSerializable()
class Abonnements {
  Abonnements();

  @JsonKey(required: true)
  int? id;
  String? name;
  String? description;
  @JsonKey(name: 'created_at')
  late DateTime created_at = DateTime.timestamp();
  @JsonKey(name: 'update_at')
  late DateTime update_at = DateTime.timestamp();

  factory Abonnements.fromJson(Map<String, dynamic> json) =>
      _$AbonnementsFromJson(json);

  Map<String, dynamic> toJson() => _$AbonnementsToJson(this);
}
