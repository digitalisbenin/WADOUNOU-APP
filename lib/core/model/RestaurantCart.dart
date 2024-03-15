import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';

class RestaurantCart {
  final Repas repas;
  final int quantity;

  RestaurantCart({required this.repas, required this.quantity});

  double getTotalRestaurantItemsPrice() {
    // Convertir le prix de la chaîne à double
    double prix = double.parse(repas.prix.toString());
    // Calculer le prix total
    return prix * quantity;
  }
}