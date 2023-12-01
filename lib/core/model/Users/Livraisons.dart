import 'package:json_annotation/json_annotation.dart';

part 'Livraisons.g.dart';

@JsonSerializable()
class Livraisons {
  Livraisons();

  @JsonKey(required: true)
  int? id;
  @JsonKey(name: 'commande_id')
  int? commande_id;
  @JsonKey(name: 'livreur_id')
  int? livreur_id;
  String? name;
  String? description;
  String? addrese;
  String? phone;
  String? status;
  @JsonKey(name: 'created_at')
  late DateTime created_at = DateTime.timestamp();
  @JsonKey(name: 'update_at')
  late DateTime update_at = DateTime.timestamp();

  factory Livraisons.fromJson(Map<String, dynamic> json) =>
      _$LivraisonsFromJson(json);

  Map<String, dynamic> toJson() => _$LivraisonsToJson(this);
}
