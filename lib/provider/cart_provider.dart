import 'package:digitalis_restaurant_app/core/model/Cart.dart';
import 'package:digitalis_restaurant_app/core/model/RestaurantCart.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/order_items.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant_order_item.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Cart> _cartItems = [];
  final List<RestaurantCart> _restaurantCartItems = [];

  List<Cart> get cartItems => _cartItems;
  List<RestaurantCart> get restaurantCartItems => _restaurantCartItems;

  double getTotalPrice() {
    double totalPrice = 0.0;

    for (var cartItem in cartItems) {
      totalPrice += cartItem.getTotalPrice();
    }

    return totalPrice;
  }

  double getTotalRestaurantItemsPrice() {
    double restaurantItemTotalPrice = 0.0;

    for (var restaurantCartItem in restaurantCartItems) {
      restaurantItemTotalPrice += restaurantCartItem.getTotalRestaurantItemsPrice();
    }

    return restaurantItemTotalPrice;
  }

  List<OrderItem> getOrderItems() {
    return cartItems.map((cartItem) {
      return OrderItem(
        repasId: cartItem.repas.id.toString(),
        quantity: cartItem.numOfItems.toString(),
        totalPrice: cartItem.getTotalPrice().toString(),
      );
    }).toList();
  }

  List<RestaurantOrderItem> getRestaurantOrderItems() {
    return restaurantCartItems.map((restaurantCartItem) {
      return RestaurantOrderItem(
        repasId: restaurantCartItem.repas.id.toString(),
        quantity: restaurantCartItem.quantity.toString(),
        totalPrice: restaurantCartItem.getTotalRestaurantItemsPrice().toString(),
      );
    }).toList();
  }

  void addToCart(Repas repas, BuildContext context) {
    int index = _cartItems.indexWhere((item) => item.repas.id == repas.id);
    if (index != -1) {
      // Le produit est déjà dans le panier
      showMessageCart(
          message: "Ce repas est déjà dans votre panier", context: context);
    } else {
      _cartItems.add(Cart(repas: repas, numOfItems: 1));
      notifyListeners();
      showMessageCart(message: "Ajouté au panier", context: context);
    }
  }

  void addToCartFromRestaurant(Repas repas, BuildContext context) {
    // Vérifie si le repas est déjà dans le panier
    int existingItem =
        _restaurantCartItems.indexWhere((restoItem) => restoItem.repas.id == repas.id);

    if (existingItem != -1) {
      showMessageCart(
          message: "Ce repas est déjà dans le panier de votre restaurant",
          context: context);
    } else {
      _restaurantCartItems.add(RestaurantCart(repas: repas, quantity: 1));
      notifyListeners();
      showMessageCart(
          message: "Ajouté au panier du restaurant", context: context);
    }
  }

  void increaseQuantity(Cart cartItem) {
    int index =
        _cartItems.indexWhere((item) => item.repas.id == cartItem.repas.id);
    if (index != -1) {
      _cartItems[index] =
          Cart(repas: cartItem.repas, numOfItems: cartItem.numOfItems + 1);
      notifyListeners();
    }
  }

  void decreaseQuantity(Cart cartItem) {
    int index =
        _cartItems.indexWhere((item) => item.repas.id == cartItem.repas.id);
    if (index != -1 && _cartItems[index].numOfItems > 1) {
      _cartItems[index] =
          Cart(repas: cartItem.repas, numOfItems: cartItem.numOfItems - 1);
      notifyListeners();
    }
  }

  void increaseRestaurantItemQuantity(RestaurantCart restaurantItem) {
    int index =
        _restaurantCartItems.indexWhere((item) => item.repas.id == restaurantItem.repas.id);
    if (index != -1) {
      _restaurantCartItems[index] =
          RestaurantCart(repas: restaurantItem.repas, quantity: restaurantItem.quantity + 1);
      notifyListeners();
    }
  }

  void decreaseRestaurantItemQuantity(RestaurantCart restaurantItem) {
    int index =
        _restaurantCartItems.indexWhere((item) => item.repas.id == restaurantItem.repas.id);
    if (index != -1 && _restaurantCartItems[index].quantity > 1) {
      _restaurantCartItems[index] =
          RestaurantCart(repas: restaurantItem.repas, quantity: restaurantItem.quantity - 1);
      notifyListeners();
    }
  }

  void removeCartItem(Cart cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void removeRestaurantCartItem(RestaurantCart restaurantItem) {
    _restaurantCartItems.remove(restaurantItem);
    notifyListeners();
  }
}

void showMessageCart({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  ));
}

/* void addToCard(BuildContext context,Repas repas){
  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
cartProvider.addToCard(repas, context);
} */

 