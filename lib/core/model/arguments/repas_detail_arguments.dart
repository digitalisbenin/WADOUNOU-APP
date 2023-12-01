import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';

class ProductDetailArguments {
  final Repas repas;
  final Restaurant? restaurant;

  ProductDetailArguments({required this.repas, this.restaurant});
}