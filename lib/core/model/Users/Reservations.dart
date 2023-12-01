// To parse this JSON data, do
//
//     final reservations = reservationsFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'Reservations.g.dart';

Reservations reservationsFromJson(String str) => Reservations.fromJson(json.decode(str));

String reservationsToJson(Reservations reservations) => json.encode(reservations.toJson());

@JsonSerializable()
class Reservations {
    String? name;
    String? date;
    String? contact;
    int? place;
    String? description;
    String? restaurantId;

    Reservations({
        this.name,
        this.date,
        this.contact,
        this.place,
        this.description,
        this.restaurantId,
    });

    
factory Reservations.fromJson(Map<String, dynamic> json) =>
      _$ReservationsFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationsToJson(this);
}


