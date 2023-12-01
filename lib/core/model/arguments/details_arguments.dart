import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';

class DetailArguments {
  final ProductDetailArguments? productArguments;
  final RestaurantDetailArgument? restaurantArguments;

  DetailArguments({
    this.productArguments,
    this.restaurantArguments,
  });
}