import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';

class Cart {
  final Repas repas;
  final int numOfItems;

  Cart({
    required this.repas, required this.numOfItems,
  });

   double getTotalPrice() {
    // Convertir le prix de la chaîne à double
    double prix = double.parse(repas.prix.toString());
    // Calculer le prix total
    return prix * numOfItems;
  }
}



/* List<Repas> demorepas = [];

List<Cart> demoCart = [
  Cart(repas: demorepas[0], numOfItems: 3),
  Cart(repas: demorepas[2], numOfItems: 1),
  Cart(repas: demorepas[1], numOfItems: 4),
]; */