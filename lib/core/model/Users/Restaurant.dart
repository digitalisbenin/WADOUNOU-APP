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

  final String id;
  final String adresse;
  final String specialite;
  final String name;
  final String description;
  final String imageUrl;
  final String heure_douverture;
  final String heure_fermeture;
  final String mtnpay;
  final String moovpay;
  final String celtispay;


  Restaurant({
    required this.heure_douverture,
    required this.heure_fermeture,
    required this.specialite,
    required this.adresse,
    required this.id,
    required this.name,
    required this.description,
    required this.mtnpay,
    required this.moovpay,
    required this.celtispay,
    required this.imageUrl});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      adresse: json['adresse'],
      specialite: json['specialite']['name'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      heure_douverture: json['heure_douverture'] ?? '',
      heure_fermeture: json['heure_fermeture'] ?? '',
      mtnpay: json['mtnpay'] ?? '',
      moovpay: json['moovpay'] ?? '',
      celtispay: json['celtispay'] ?? '',
    );
  }

  /* factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json); */

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}