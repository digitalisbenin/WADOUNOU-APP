// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reservations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservations _$ReservationsFromJson(Map<String, dynamic> json) => Reservations(
      name: json['name'] as String?,
      date: json['date'] as String?,
      contact: json['contact'] as String?,
      place: json['place'] as int?,
      description: json['description'] as String?,
      restaurantId: json['restaurantId'] as String?,
    );

Map<String, dynamic> _$ReservationsToJson(Reservations instance) =>
    <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'contact': instance.contact,
      'place': instance.place,
      'description': instance.description,
      'restaurantId': instance.restaurantId,
    };
