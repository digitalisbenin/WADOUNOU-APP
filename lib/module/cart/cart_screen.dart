import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Commandes.dart';
import 'package:digitalis_restaurant_app/core/model/cart_model.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/helpers/cart/cart_db_helper.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/custom_back_ios_button.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/widgets/default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static String routeName = "/cart_page";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartDBHelper? cartDBHelper = CartDBHelper();
  final _formkey = GlobalKey<FormState>();

  String? name;
  String? address;
  String? contact;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    _nameController.clear();
    _addressController.clear();
    _contactController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Mon Paniers '),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: badge.Badge(
              showBadge: true,
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              badgeAnimation: const badge.BadgeAnimation.slide(
                  animationDuration: Duration(milliseconds: 300)),
              badgeStyle: const badge.BadgeStyle(
                badgeColor: kPrimaryColor,
              ),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/empty_cart.png'),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text('😞 Votre panier est vide pour le moment 🤪',
                              style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          /*  Image.asset(snapshot
                                                .data![index].image
                                                .toString(), height: 100, width: 100,),
                                          const SizedBox(
                                            width: 12,
                                          ), */
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          cartDBHelper!.delete(
                                                              snapshot
                                                                  .data![index]
                                                                  .id!);
                                                          cart.decreaseCounter();
                                                          cart.decreaseTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString()));
                                                        },
                                                        child: const Icon(
                                                            Icons.delete))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data![index]
                                                          .description
                                                          .toString() +
                                                      " " +
                                                      r"FCFA " +
                                                      snapshot.data![index]
                                                          .productPrice
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                int quantity =
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                double price =
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!;
                                                                quantity--;

                                                                double?
                                                                    newPrice =
                                                                    price *
                                                                        quantity;

                                                                if (quantity >
                                                                    0) {
                                                                  cartDBHelper!
                                                                      .updateQuantity(CartModel(
                                                                          id: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id!,
                                                                          productId: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productId!
                                                                              .toString(),
                                                                          productName: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productName!,
                                                                          initialPrice: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .initialPrice!,
                                                                          productPrice: newPrice
                                                                              .toDouble(),
                                                                          quantity:
                                                                              quantity,
                                                                          description: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .description
                                                                              .toString(),
                                                                          image: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .image
                                                                              .toString()))
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cart.decreaseTotalPrice(double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString()));
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    print(error
                                                                        .toString());
                                                                  });
                                                                }
                                                              },
                                                              child: const Icon(
                                                                CupertinoIcons
                                                                    .minus,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .quantity
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity!;
                                                                  double price = snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!;
                                                                  quantity++;

                                                                  double
                                                                      newPrice =
                                                                      price *
                                                                          quantity;

                                                                  cartDBHelper!
                                                                      .updateQuantity(CartModel(
                                                                          id: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id!,
                                                                          productId: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productId!
                                                                              .toString(),
                                                                          productName: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productName!,
                                                                          initialPrice: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .initialPrice!,
                                                                          productPrice:
                                                                              newPrice,
                                                                          quantity:
                                                                              quantity,
                                                                          description: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .description
                                                                              .toString(),
                                                                          image: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .image
                                                                              .toString()))
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cart.addTotalPrice(double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString()));
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    print(error
                                                                        .toString());
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  CupertinoIcons
                                                                      .add,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }));
                  }
                } else {
                  return const Text('');
                }
              },
            ),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                      ? false
                      : true,
                  child: Column(
                    children: [
                      ReusableWidget(
                          title: 'Sous Total',
                          value: r'FCFA ' +
                              value.getTotalPrice().toStringAsFixed(2)),
                      const ReusableWidget(
                          title: 'Rabais 5%', value: r'FCFA ' + '500'),
                      ReusableWidget(
                          title: 'Total',
                          value: r'FCFA ' +
                              value.getTotalPrice().toStringAsFixed(2)),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      AppFilledButton(
                        text: "Passer à la commande",
                        onPressed: () {
                          _showBottomSheet(context);
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      /*DefaultButton(
                        text: 'Passer à la commande',
                        press: () {},
                      ),*/
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.53,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.95,
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    // clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          child: Container(
                            width: 60,
                            height: 7,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.022,
                          ),
                          const Center(
                            child: Text(
                              "Détails sur la commande",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: TextFormField(
                                    controller: _nameController,
                                    cursorColor: kTextColor,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Nom complet",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: kTextColor)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Veuillez saisir votre nom complet";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: TextFormField(
                                    controller: _addressController,
                                    cursorColor: kTextColor,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Adresse de livraison",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: kTextColor)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Vous devez nous fournir une adresse de livraison";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: TextFormField(
                                    controller: _contactController,
                                    cursorColor: kTextColor,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Numéro de téléphone",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: kTextColor)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Vous devez nous fournir un numéro de téléphone";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.04,
                                ),
                                AppFilledButton(
                                  text: "Commander maintenant !",
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      name = _nameController.text.trim();
                                      address = _addressController.text.trim();
                                      contact = _contactController.text.trim();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.06,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Fermer",
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}

class ReusableWidget extends StatelessWidget {
  const ReusableWidget({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                value.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          ],
        ),
        const Divider(
          height: 8,
        )
      ],
    );
  }
}
