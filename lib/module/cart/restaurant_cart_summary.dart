import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Cart.dart';
import 'package:digitalis_restaurant_app/core/model/RestaurantCart.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant_order_item.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/kkiaPay_sample.dart';
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/success_screen.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/core/model/order_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';

class RestaurantCartSummary extends StatefulWidget {
  final double subTotal;
  final double shipping_cost;
  final double total;
  final List<RestaurantCart> restaurantCartItems;
  final String restaurantId;

  RestaurantCartSummary({
    required this.subTotal,
    required this.shipping_cost,
    required this.total,
    required this.restaurantCartItems,
    required this.restaurantId,
  });

  @override
  State<RestaurantCartSummary> createState() => _RestaurantCartSummaryState();
}

class _RestaurantCartSummaryState extends State<RestaurantCartSummary> {
  double getTotalRestaurantItemsPrice() {
    // Logique pour calculer le prix total
    double totalPrice = 0.0;
    for (var restaurantCartItem in widget.restaurantCartItems) {
      totalPrice += restaurantCartItem.getTotalRestaurantItemsPrice();
    }
    return totalPrice;
  }

  int getNumOfItems() {
    // Logique pour calculer le nombre total d'articles
    int quantity = 0;
    for (var restaurantCartItem in widget.restaurantCartItems) {
      quantity += restaurantCartItem.quantity;
    }
    return quantity;
  }

  final _formkey = GlobalKey<FormState>();
  String? repasId;

  String? name;
  String? address;
  String? contact;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<RestaurantOrderItem> restaurantOrderItems = [];

  void _showBottomSheet(BuildContext context) {
    void placeOrderFromRestaurantCart() {
      // Appeler ordering.postOrder ici avec les données nécessaires
      Provider.of<OrderProvider>(context, listen: false).placeOrderFromRestaurantCart(
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        contact: _contactController.text.trim(),
        description: _descriptionController.text.trim(),
        montant: getTotalRestaurantItemsPrice().toString(),
        quantite: getNumOfItems().toString(),
        status: "En cours",
        restaurantItems: restaurantOrderItems,
        context: context,
      );
    }

    void successCallback(response, context) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            amount: getTotalRestaurantItemsPrice(),
            transactionId: response['transactionId'],
            postOrderCallback: placeOrderFromRestaurantCart,
          ),
        ),
      );
      placeOrderFromRestaurantCart();
    }

    Future<bool> openKkiapayPayment() async {
      // Créez une instance KKiaPay avec le montant actuel
      final kkiapay = KKiaPay(
          amount: getTotalRestaurantItemsPrice().toInt(),
          countries: ["BJ"],
          phone: _contactController.text.trim().toString(),
          name: _nameController.text.trim().toString(),
          email: "",
          reason: 'transaction reason',
          data: 'Fake data',
          sandbox: true,
          apikey: 'd81f7db084ba11eea99e794f985e5009',
          callback: successCallback,
          theme: defaultTheme,
          paymentMethods: ["momo", "card"]);

// Ouvrez l'écran Kkiapay
      final success = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => KkiapaySample(kkiapay: kkiapay)),
      );

      return success ?? false;
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kWhite,
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
                            borderRadius: BorderRadius.circular(5)),
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
                                    cursorColor: kPrimaryColor,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Nom complet",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: kTextColor)),
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
                                    cursorColor: kPrimaryColor,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Adresse de livraison",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: kTextColor)),
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
                                    cursorColor: kPrimaryColor,
                                    keyboardType: TextInputType.phone,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Numéro de téléphone",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: kTextColor)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Renseignez votre numéro de téléphone";
                                      }

                                      if (value.length == 8 ||
                                          value.length == 12 ||
                                          value.length == 13) {
                                        return null; // La taille du numéro de téléphone est valide
                                      } else {
                                        return "Le numéro de téléphone n'est pas valide";
                                      }
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
                                    controller: _descriptionController,
                                    cursorColor: kPrimaryColor,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    maxLines: 3,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Motif de la commande (facultatif)",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: kTextColor)),
                                    /* validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Vous devez nous fournir une adresse de livraison";
                                      }
                                      return null;
                                    },*/
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.04,
                                ),
                                Consumer<OrderProvider>(builder:
                                    (context, orderingFromRestaurantCart, child) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (orderingFromRestaurantCart.resMessage != '') {
                                      showMessage(
                                          message: orderingFromRestaurantCart.resMessage,
                                          context: context);
                                      orderingFromRestaurantCart.quickClear();
                                    }
                                  });
                                  return AppFilledButton(
                                    text: "Commander maintenant !",
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();
                                        restaurantOrderItems = widget.restaurantCartItems
                                            .map((e) => RestaurantOrderItem(
                                                  name: _nameController.text
                                                      .trim(),
                                                  description:
                                                      _descriptionController
                                                          .text
                                                          .trim(),
                                                  adresse: _addressController
                                                      .text
                                                      .trim(),
                                                  contact: _contactController
                                                      .text
                                                      .trim(),
                                                  status: 'En cours',
                                                  repasId: e.repas.id,
                                                  quantity:
                                                      e.quantity.toString(),
                                                  totalPrice: e
                                                      .getTotalRestaurantItemsPrice()
                                                      .toString(),
                                                ))
                                            .toList();
                                        /* orderingFromCart.sayHello(); */

                                        debugPrint(
                                            "::::::::::::::: id du restaurant :  ${widget.restaurantId}");

                                        final success =
                                            await openKkiapayPayment();

                                        if (success) {
                                          orderingFromRestaurantCart.placeOrderFromRestaurantCart(
                                              name: _nameController.text
                                                  .toString()
                                                  .trim(),
                                              address: _addressController.text
                                                  .toString()
                                                  .trim(),
                                              contact: _contactController.text
                                                  .toString()
                                                  .trim(),
                                              description:
                                                  _descriptionController.text
                                                      .toString()
                                                      .trim(),
                                              status: 'En cours',
                                              restaurantItems: restaurantOrderItems,
                                              montant:
                                                  getTotalRestaurantItemsPrice().toString(),
                                              quantite:
                                                  getNumOfItems().toString());
                                        } else {
                                          // Gérer l'échec du paiement
                                          showMessage(
                                              message: 'Échec du paiement',
                                              context: context);
                                        }
                                        debugPrint(
                                            "------ ${restaurantOrderItems.length}");
                                        debugPrint(
                                            "------contact ${_contactController.text}");
                                        debugPrint("------success ");
                                      } else if (_nameController.text.isEmpty ||
                                          _contactController.text.isEmpty ||
                                          _addressController.text.isEmpty) {
                                        showMessage(
                                          message:
                                              'Tous les champs sont obligatoires',
                                          context: context,
                                        );
                                        dispose();
                                      }
                                    },
                                  );
                                }),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.06,
                                ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableWidget(
            title: 'Sous Total',
            value: '${widget.subTotal.toStringAsFixed(2)} FCFA'),
        const ReusableWidget(title: 'Livraison', value: '500 FCFA'),
        ReusableWidget(
            title: 'Total', value: '${widget.total.toStringAsFixed(2)} FCFA'),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        AppFilledButton(
          text: "Passer à la commande",
          onPressed: () {
            debugPrint('----id du resto : ${widget.restaurantId}');
            _showBottomSheet(context);
          },
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
      ],
    );
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
