import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/cart/cart_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/meals/widgets/meal_by_categorie.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;

class AllMealsByCategorieScreen extends StatefulWidget {
  const AllMealsByCategorieScreen({super.key});

  @override
  State<AllMealsByCategorieScreen> createState() => _AllMealsByCategorieScreenState();
}

class _AllMealsByCategorieScreenState extends State<AllMealsByCategorieScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kOnBoardingBackgroundColor,
        title: const Text('Buffets', style: TextStyle(color: kWhite),),
        centerTitle: true,
      ),
      body: const Center(
        child: MealByCategorieBody(),
      ),
      /*floatingActionButton: Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ]),
        child: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          int cartItemCount = cartProvider.cartItems.length;

          return badge.Badge(
            showBadge: cartItemCount > 0,
            badgeContent: Text(
              cartItemCount.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            badgeAnimation: const badge.BadgeAnimation.slide(
              animationDuration: Duration(milliseconds: 300),
            ),
            badgeStyle: const badge.BadgeStyle(badgeColor: kPrimaryColor),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: kPrimaryColor,
              ),
            ),
          );
        }),
      ),*/
    );
  }
}
