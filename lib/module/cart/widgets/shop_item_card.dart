import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:digitalis_restaurant_app/core/model/Cart.dart'; // Assure-toi d'importer correctement le modèle Cart
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';

class CartItemCard extends StatelessWidget {
  final List<Cart> cartItems; // Assure-toi d'avoir la liste correcte ici

  const CartItemCard({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: SizeConfig.screenHeight * 0.14,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 6.7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: cartItems[index].repas.image_url != null
                      ? Image.network(
                          cartItems[index].repas.image_url!,
                          height: SizeConfig.screenHeight * 0.08,
                          width: SizeConfig.screenWidth * 0.18,
                        )
                      : Image.asset('assets/images/téléchargement (1).png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalSpaceTiny,
                    Text(
                      "${cartItems[index].repas.name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceSmall,
                    Text(
                      "${cartItems[index].repas.description}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    verticalSpaceTiny,
                    verticalSpaceTiny,
                    Text(
                      "${cartItems[index].repas.prix} FCFA",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    verticalSpaceTiny,
                    verticalSpaceTiny,
                  ],
                ),
                // Ajoute le reste du code nécessaire ici selon tes besoins
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}






/* return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: SizeConfig.screenHeight * 0.14,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6.7,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      cartProvider.cartItems.,
                      height: SizeConfig.screenHeight * 0.08,
                      width: SizeConfig.screenWidth * 0.18,
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        verticalSpaceTiny,
                        Text(
                          widget.cart.repas.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          widget.cart.repas.description,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        verticalSpaceTiny,
                        verticalSpaceTiny,
                        Text(
                          "${widget.cart.repas.price} FCFA",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        verticalSpaceTiny,
                        verticalSpaceTiny,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cartProvider.increaseQuantity(widget.cart);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "$_numberOfItem",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cartProvider.decreaseQuantity(widget.cart);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ); */