import 'package:digitalis_restaurant_app/core/model/Users/Commandes.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';

class ProductDetailArguments {
  final Repas repas;
  final Commandes? commandes;
  final Restaurant? restaurant;

  ProductDetailArguments({required this.repas, this.restaurant, this.commandes,});
}