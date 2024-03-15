import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Cart.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/cart/cart_summary.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;

class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  static String routeName = "/cart_page";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Mon Panier'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
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
                  badgeStyle: const badge.BadgeStyle(
                    badgeColor: kPrimaryColor,
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                List<Cart> cartItems = cartProvider.cartItems;
                return cartItems.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/empty_cart.png'),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Votre panier est vide pour le moment 🤪',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
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
                                  cartItems[index].repas.image_url != null
                                      ? Image.network(
                                          cartItems[index].repas.image_url!,
                                          height:
                                              SizeConfig.screenHeight * 0.08,
                                          width: SizeConfig.screenWidth * 0.18,
                                        )
                                      : Image.asset(
                                          'assets/images/téléchargement (1).png'),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${cartItems[index].repas.name}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                cartProvider.removeCartItem(
                                                    cartItems[index]);
                                              },
                                              child: const Icon(Icons.delete))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${cartItems[index].getTotalPrice().toStringAsFixed(0)} FCFA",
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
                                                            .decreaseQuantity(
                                                                cartItems[
                                                                    index]);
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons.minus,
                                                        color: kWhite,
                                                      )),
                                                  Text(
                                                    "${cartItems[index].numOfItems}",
                                                    style: const TextStyle(
                                                        color: kWhite),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cartProvider
                                                          .increaseQuantity(
                                                              cartItems[index]);
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
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Visibility(
                  visible: cartProvider.getTotalPrice() == 0.0 ? false : true,
                  child: CartSummary(
                    subTotal: cartProvider.getTotalPrice(),
                    shipping_cost: 500, // Remplacez cela par la valeur réelle de livraison
                    total: cartProvider.getTotalPrice() +
                        500, cartItems: cartProvider.cartItems, // Remplacez cela par la formule réelle
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}




 /* ListTile(
                        title: Text("${cartItems[index].repas.name}"),
                        subtitle: Text("${cartItems[index].numOfItems}"),
                      ); */