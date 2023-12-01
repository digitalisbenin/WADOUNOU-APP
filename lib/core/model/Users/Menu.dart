// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Menu.g.dart';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu menu) => json.encode(menu.toJson());

class MenuModel {
    List<Menu> menu;

    MenuModel({
        required this.menu,
    });

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
    };
}

@JsonSerializable()
class Menu {
    String? id;
    String? name;
    String? description;
    String? prix;
    List<Repas>? repasList;
   // Restaurant? restaurant;

    Menu({
        this.id,
        this.name,
        this.description,
        this.prix,
        this.repasList,
      //  this.restaurant,
    });

    factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      prix: json['prix'],
      repasList: [Repas.fromJson(json["repas"])],
     // restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }

    /* factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json); */

    Map<String, dynamic> toJson() => _$MenuToJson(this);
}