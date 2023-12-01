
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';


Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

@JsonSerializable()
class Users {
  String id;
  String name;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  String profilePhotoUrl;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}


/*class User {
  User();

  @JsonKey(required: true)
  String? name;
  String? email;
  @JsonKey(name: 'email_verified_at')
  late DateTime email_verified_at = DateTime.timestamp();
  String? password;
  //String? deviceToken;
 // String? profile_photo_path;
  @JsonKey(name: 'created_at')
  late DateTime created_at = DateTime.timestamp();
  @JsonKey(name: 'update_at')
  late DateTime update_at = DateTime.timestamp();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}*/
