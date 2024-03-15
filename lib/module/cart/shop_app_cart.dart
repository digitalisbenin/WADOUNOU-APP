import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:badges/badges.dart' as badge;
import 'package:digitalis_restaurant_app/core/model/Cart.dart';
import 'package:digitalis_restaurant_app/core/model/RestaurantCart.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/cart/restaurant_cart_summary.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopAppCart extends StatefulWidget {
  const ShopAppCart({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<ShopAppCart> createState() => _ShopAppCartState();
}

class _ShopAppCartState extends State<ShopAppCart> {
  @override
  Widget build(BuildContext context) {
    debugPrint("ID du restaurant dans le panier : ${widget.restaurantId}");
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Mon Paniers '),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child:
                Consumer<CartProvider>(builder: (context, cartProvider, child) {
              int cartItemCount = cartProvider.restaurantCartItems.length;

              return badge.Badge(
                showBadge: cartItemCount > 0,
                badgeContent: Text(
                  cartItemCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                badgeStyle: const badge.BadgeStyle(badgeColor: kPrimaryColor),
                child: const Icon(
                  CupertinoIcons.cart,
                ),
              );
            }),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                Consumer<CartProvider>(builder: (context, cartProvider, child) {
              List<RestaurantCart> restaurantCartItems = cartProvider.restaurantCartItems;
              return restaurantCartItems.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/empty_cart.png'),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          //  Donc c'est ici on va
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Votre panier est vide pour le moment 🤪',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: restaurantCartItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    restaurantCartItems[index]
                                                .repas
                                                .image_url !=
                                            null
                                        ? Image.network(
                                            restaurantCartItems[index]
                                                .repas
                                                .image_url!,
                                            height:
                                                SizeConfig.screenHeight * 0.08,
                                            width:
                                                SizeConfig.screenWidth * 0.18,
                                          )
                                        : Image.asset(
                                            'assets/images/téléchargement (1).png'),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${restaurantCartItems[index].repas.name}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  cartProvider
                                                      .removeRestaurantCartItem(
                                                          restaurantCartItems[
                                                              index]);
                                                },
                                                child: const Icon(Icons.delete))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${restaurantCartItems[index].getTotalRestaurantItemsPrice().toStringAsFixed(0)} FCFA",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          cartProvider
                                                              .decreaseRestaurantItemQuantity(
                                                                  restaurantCartItems[
                                                                      index]);
                                                        },
                                                        child: const Icon(
                                                          CupertinoIcons.minus,
                                                          color: kWhite,
                                                        )),
                                                    Text(
                                                      "${restaurantCartItems[index].quantity}",
                                                      style: const TextStyle(
                                                          color: kWhite),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        cartProvider
                                                            .increaseRestaurantItemQuantity(
                                                                restaurantCartItems[
                                                                    index]);
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons.add,
                                                        color: kWhite,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }),
          ),
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Visibility(
                visible: cartProvider.getTotalRestaurantItemsPrice() == 0.0
                    ? false
                    : true,
                child: RestaurantCartSummary(
                  subTotal: cartProvider.getTotalRestaurantItemsPrice(),
                  shipping_cost:
                      500, // Remplacez cela par la valeur réelle de livraison
                  total: cartProvider.getTotalRestaurantItemsPrice() + 500,
                  restaurantCartItems: cartProvider
                      .restaurantCartItems, // Remplacez cela par la formule réelle
                  restaurantId:
                      widget.restaurantId, // Passer l'ID du restaurant
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
