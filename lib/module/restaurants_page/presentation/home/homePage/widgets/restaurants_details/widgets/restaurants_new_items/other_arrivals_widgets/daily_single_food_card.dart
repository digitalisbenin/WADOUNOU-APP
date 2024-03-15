import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/provider/comment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DailySingleFoodCard extends StatefulWidget {
  const DailySingleFoodCard({
    Key? key,
    required this.repas,
    required this.press,
    required this.restaurantId, /* required this.prix, */
  }) : super(key: key);

  final Repas repas;
  /* final String prix; */
  final GestureTapCallback press;
  final String restaurantId;

  @override
  State<DailySingleFoodCard> createState() => _DailySingleFoodCardState();
}

class _DailySingleFoodCardState extends State<DailySingleFoodCard> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

   void addToCartFromRestaurant() {
    Provider.of<CartProvider>(context, listen: false).addToCartFromRestaurant(widget.repas, context);
    /* showMessage(message: 'Ajouté au panier', context: context); */
  }

  @override
  Widget build(BuildContext context) {
    Repas repas = widget.repas;

    return SizedBox(
      width: SizeConfig.screenWidth * 0.48,
      height: SizeConfig.screenHeight * 0.33,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: GestureDetector(
          onTap: widget.press,
          child: Container(
            width: SizeConfig.screenWidth * 0.44,
            height: SizeConfig.screenHeight * 0.28,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        size: SizeConfig.screenHeight * 0.026,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        repas.image_url.toString(),
                        height: SizeConfig.screenHeight * 0.16,
                      ),
                    ),
                  ),
                  Text(
                    repas.name.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Text(
                    repas.categoris?.name ??
                        '', // Utilisation du champ "name" de "categoris", avec gestion de null
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.blue, // Couleur que vous souhaitez utiliser
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  /* SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Text(
                    repas.description.toString(),
                    style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.016,
                        overflow: TextOverflow.ellipsis),
                  ), */
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${double.parse(widget.repas.prix ?? '0').toStringAsFixed(0)} FCFA",
                        style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.017,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'Commentaires',
                                content: Center(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                          child: TextFormField(
                                            controller: _nameController,
                                            cursorColor: kTextColor,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                hintText: "Noms",
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                    color: kTextColor)),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Ce champ est obligatoire";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.02,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 3.0),
                                          child: TextFormField(
                                            controller: _descriptionController,
                                            cursorColor: kTextColor,
                                            maxLines: 5,
                                            maxLength: 20,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Quelles sont vos impressions sur ce repas (obligatoire)",
                                                border: InputBorder.none,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                hintStyle: TextStyle(
                                                    color: kTextColor)),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Ce champ est obligatoire";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  Consumer<CommentProvider>(builder:
                                      (context, commentPosting, child) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (commentPosting.resMessage != '') {
                                        showMessage(
                                            message: commentPosting.resMessage,
                                            context: context);
                                        commentPosting.clear();
                                      }
                                    });
                                    return MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          commentPosting.postComment(
                                              name: _nameController.text.trim(),
                                              content: _descriptionController
                                                  .text
                                                  .trim(),
                                              repas_id:
                                                  widget.repas.id.toString(),
                                              context: context);
                                          dispose();
                                        } else if (_nameController
                                                .text.isEmpty ||
                                            _descriptionController
                                                .text.isEmpty) {
                                          showMessage(
                                            message:
                                                'Certains champs sont obligatoire',
                                            context: context,
                                          );
                                        }
                                      },
                                      color: Colors.green,
                                      child: const Text(
                                        'Envoyer',
                                        style: TextStyle(color: kWhite),
                                      ),
                                    );
                                  })
                                ]);
                          },
                          child: Icon(
                            CupertinoIcons.chat_bubble_text,
                            size: SizeConfig.screenHeight * 0.024,
                            color: kTextColor,
                          )),
                      InkWell(
                        onTap: addToCartFromRestaurant,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 7),
                              child: Icon(
                                Icons.shopping_cart_checkout,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
