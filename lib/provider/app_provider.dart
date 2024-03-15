// app_provider.dart

import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/provider/restaurant_provider/get_restaurant_service.dart';
import 'package:flutter/material.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';

class AppProvider with ChangeNotifier {
  List<Repas> repas = [];
  List<Restaurant> restaurants = [];

  Future<void> updateData() async {
    // Mettez à jour les données globales ici
    // Par exemple, rechargez les repas et les restaurants depuis la base de données

    try {
      // Chargez les nouvelles données depuis la base de données
      List<Repas> newRepas = await RepasList.getRepas();
      List<Restaurant> newRestaurants = await RestaurantList.getRestaurants();

      // Mettez à jour les listes avec les nouvelles données
      repas = newRepas;
      restaurants = newRestaurants;

      // Attendez un peu pour simuler le chargement de nouvelles données
      await Future.delayed(Duration(seconds: 5));

      // Notifiez les écouteurs que les données ont été mises à jour
      notifyListeners();
    } catch (e) {
      // Gérez les erreurs si nécessaire
      print("Erreur lors de la mise à jour des données : $e");
    }
  }
}
