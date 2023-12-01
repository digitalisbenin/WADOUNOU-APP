import 'package:json_annotation/json_annotation.dart';

part 'Livreurs.g.dart';

@JsonSerializable()
class Livreurs {
  Livreurs();

  @JsonKey(required: true)
  int? id;
  @JsonKey(name: 'restaurant_id')
  int? restaurant_id;
  @JsonKey(name: 'user_id')
  int? user_id;
  String? name;
  String? description;
  String? addrese;
  String? phone;
  @JsonKey(name: 'created_at')
  late DateTime created_at = DateTime.timestamp();
  @JsonKey(name: 'update_at')
  late DateTime update_at = DateTime.timestamp();

  factory Livreurs.fromJson(Map<String, dynamic> json) =>
      _$LivreursFromJson(json);

  Map<String, dynamic> toJson() => _$LivreursToJson(this);
}
