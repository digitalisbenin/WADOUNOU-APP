import 'dart:convert';

import 'package:digitalis_restaurant_app/core/model/Users/Menu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Restaurant.g.dart';


Restaurant restaurantFromJson(String str) => Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant restaurant) => json.encode(restaurant.toJson());

class RestaurantModel {
  List<Restaurant> restaurant;

  RestaurantModel({
    required this.restaurant,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    restaurant: List<Restaurant>.from(json["restaurant"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurant": List<dynamic>.from(restaurant.map((x) => x.toJson())),
  };
}

@JsonSerializable()
class Restaurant {

  String? id;
  String? name;
  String? adresse;
  String? phone;
  String? description;
  String? specilite;
  Menu? menu;

  String? heure_douverture;
  String? heure_fermeture;
  String? document_url;
  String? capacite;
  String? image_url;

  Restaurant({
    this.id,
    this.name,
    this.adresse,
    this.phone,
    this.description,
    this.specilite,
    this.menu,
    this.heure_douverture,
    this.heure_fermeture,
    this.document_url,
    this.capacite,
    this.image_url,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
  return Restaurant(
    id: json['id'],
    name: json['name'],
    adresse: json['adresse'],
    phone: json['phone'],
    description: json['description'],
    specilite: json['specilite'],
    menu: json['repas'] == null ? null : Menu.fromJson(json['repas']),
    heure_douverture: json['heure_douverture'],
    heure_fermeture: json['heure_fermeture'],
    document_url: json['document_url'],
    capacite: json['capacite'],
    image_url: json['image_url'],
  );
}

  factory Restaurant.fromJsonNoMenu(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      adresse: json['adresse'],
      phone: json['phone'],
      description: json['description'],
      specilite: json['specilite'],
      menu: json['repas'] == null ? null : Menu.fromJson(json),
      heure_douverture: json['heure_douverture'],
      heure_fermeture: json['heure_fermeture'],
      document_url: json['document_url'],
      capacite: json['capacite'],
      image_url: json['image_url'],
    );
  }

  /* factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json); */

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}