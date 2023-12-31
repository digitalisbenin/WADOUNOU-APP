import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Commandes.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/custom_back_ios_button.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  static String routeName = "/details";

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  double newPrice = 0.0;
  int _numberOfItem = 1;

  final _formkey = GlobalKey<FormState>();

  String? repasId;

  String? name;
  String? address;
  String? contact;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void increaseNumberOfItem() {
    setState(() {
      _numberOfItem++;
    });
  }

  void decreaseNumberOfItem() {
    setState(() {
      if (_numberOfItem == 1) {
        _numberOfItem;
      } else {
        _numberOfItem--;
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailArguments? arguments =
        ModalRoute.of(context)?.settings.arguments as ProductDetailArguments?;

    double price = double.tryParse(arguments!.repas.prix ?? "") ?? 0.0;

    // double price = arguments!.repas.prix as double;
    newPrice = price * _numberOfItem;

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18.0,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.network(
                  arguments.repas.image_url.toString(),
                  height: SizeConfig.screenHeight * 0.42, //
                  width: SizeConfig.screenWidth * 0.4,
                ),
              ),
              Arc(
                edge: Edge.TOP,
                arcType: ArcType.CONVEY,
                height: SizeConfig.screenHeight * 0.04,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.04),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                "$newPrice FCFA",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  arguments.repas.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.25,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: SizeConfig.screenHeight * 0.024,
                                        decoration: BoxDecoration(
                                            color:
                                                kPrimaryColor.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: GestureDetector(
                                          onTap: decreaseNumberOfItem,
                                          child: const Icon(
                                            CupertinoIcons.minus,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "$_numberOfItem",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: SizeConfig.screenHeight * 0.024,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: GestureDetector(
                                          onTap: increaseNumberOfItem,
                                          child: const Icon(
                                            CupertinoIcons.plus,
                                            color: kPrimaryColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            arguments.repas.description.toString(),
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.1,
                        ),
                        AppFilledButton(
                          text: "Commander ce repas !",
                          onPressed: () {
                            String repasId = arguments.repas.id ?? "";
                            print("ID du repas sélectionné : $repasId");
                            _showBottomSheet(context, arguments!);
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.06,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context, ProductDetailArguments arguments) {
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
                                    cursorColor: kTextColor,
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
                                    cursorColor: kTextColor,
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
                                    cursorColor: kTextColor,
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
                                        return "Vous devez nous fournir un numéro de téléphone";
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
                                    controller: _descriptionController,
                                    cursorColor: kTextColor,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Description de la commande (facultatif)",
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
                                Consumer<OrderProvider>(
                                    builder: (context, quickOrder, child) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (quickOrder.resMessage != '') {
                                      showMessage(
                                          message: quickOrder.resMessage,
                                          context: context);
                                      quickOrder.clear();
                                    }
                                  });
                                  return AppFilledButton(
                                    text: "Commander maintenant !",
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();

                                        String? repasId = arguments.repas.id;
                                        print(
                                            'ID du repas sélectionné : $repasId');

                                        quickOrder.postOrder(
                                            name: _nameController.text.trim(),
                                            adresse:
                                                _addressController.text.trim(),
                                            contact:
                                                _contactController.text.trim(),
                                            description: _descriptionController
                                                .text
                                                .trim(),
                                            status: 'En cours',
                                            repas_id:
                                                arguments.repas.id!.toString(),
                                            restaurant_id: "",
                                            montant: newPrice.toString(),
                                            quantite: _numberOfItem.toString(),
                                            context: context);
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
