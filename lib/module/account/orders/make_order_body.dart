import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeOrderBody extends StatefulWidget {
  const MakeOrderBody({super.key});

  @override
  State<MakeOrderBody> createState() => _MakeOrderBodyState();
}

class _MakeOrderBodyState extends State<MakeOrderBody> {
  int _numberOfItem = 1;
  double? newPrice;

  final _formKey = GlobalKey<FormState>();

  Restaurant? selectedRestaurants;
  Repas? selectedRepas;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  List<DropdownMenuItem<String>> dropdownRestaurantItems = [];

  Future<List<dynamic>> fetchData() async {
    final repas = await RepasList.getRepas();
    final restaurants = await RestaurantList.getRestaurants();
    return [repas, restaurants];
  }

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
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _deliveryAddressController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text("Veuillez Patienter un moment..."),
                ],
              ),
            );
          }

          final repas = snapshot.data![0] as List<Repas>;
          final restaurants = snapshot.data![1] as List<Restaurant>;

          // Créez la liste dropdownItems avec des valeurs uniques
          final dropdownRepasItems = repas.map((repas) {
            return DropdownMenuItem<String>(
                value: repas.id, // utilisation de l'id comme valeur
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(repas.name.toString()),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text("${repas.prix.toString()} FCFA"),
                  ],
                ));
          }).toList();

          // Créez la liste dropdownItems avec des valeurs uniques
          dropdownRestaurantItems = restaurants.map((restaurant) {
              return DropdownMenuItem<String>(
                value: restaurant.id, // Utilisez l'ID comme valeur
                child: Text(restaurant.name.toString()),
              );
            }).toList();

          if (selectedRepas != null) {
            // Convertissez selectedRepas!.prix en double avant le calcul
            double prixAsDouble = double.parse(selectedRepas!.prix ?? "0.0");

            // Mettez à jour newPrice avec le résultat du calcul
            newPrice = prixAsDouble * _numberOfItem;
          }

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: DropdownButtonFormField<String>(
                      // utilisation de String comme type de la liste déroulante
                      value: selectedRepas != null ? selectedRepas!.id : null,
                      items: dropdownRepasItems,
                      onChanged: (value) {
                        final selectedRepass =
                            repas.firstWhere((repas) => repas.id == value);
                        setState(() {
                          selectedRepas = selectedRepass;
                          dropdownRestaurantItems = restaurants
                              .where((element) =>
                                  element.menu != null &&
                                  element.menu!.repasList != null &&
                                  element.menu!.repasList!
                                      .expand((r) => [r.id])
                                      .toList()
                                      .contains(selectedRepas!.id))
                              .toList()
                              .map((restaurant) {
                            return DropdownMenuItem<String>(
                              value:
                                  restaurant.id, // Utilisez l'ID comme valeur
                              child: Text(restaurant.name.toString()),
                            );
                          }).toList();

                          var rr = restaurants
                              .where((element) =>
                                  element.menu != null &&
                                  element.menu!.repasList != null &&
                                  element.menu!.repasList!
                                      .expand((r) => [r.id])
                                      .toList()
                                      .contains(selectedRepass.id))
                              .toList();

                          print('1- $selectedRepas');
                          print('2- $selectedRepass');
                          print('rr : $rr');
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Choisissez un repas ici',
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez sélectionner un repas';
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
                        horizontal: 10.0, vertical: 3.0),
                    child: DropdownButtonFormField<String>(
                      // Utilisez String comme type pour la liste déroulante
                      value: selectedRestaurants != null
                          ? selectedRestaurants!.id
                          : null,
                      items: dropdownRestaurantItems,
                      onChanged: (value) {
                        final selectedRestaurant = restaurants
                            .firstWhere((restaurant) => restaurant.id == value);
                        setState(() {
                          selectedRestaurants = selectedRestaurant;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Choisissez un restaurant',
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      /*validator: (value) {
                        if (value == null) {
                          return 'Veuillez sélectionner un restaurant';
                        }
                        return null;
                      },*/
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _quantityController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Quantité",
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
                          return "Quantité voulu";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _numberOfItem = int.parse(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Montant : "),
                            if (selectedRepas != null)
                              Text("${newPrice ?? 0.0} FCFA"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Nom & prénoms",
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: TextFormField(
                      controller: _deliveryAddressController,
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
                          return "Veuillez saisir une adresse de livraison";
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
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
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
                          return "Renseignez votre numéro de téléphone";
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
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText:
                              "Dites nous plus sur la réservation (facultatif)",
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          hintStyle: TextStyle(color: kTextColor)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Consumer<OrderProvider>(
                        builder: (context, ordering, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (ordering.resMessage != '') {
                          showMessage(
                              message: ordering.resMessage, context: context);
                          ordering.clear();
                        }
                      });
                      return AppFilledButton(
                        text: "Commander",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ordering.postOrder(
                              name: _nameController.text.trim(),
                              adresse: _deliveryAddressController.text.trim(),
                              contact: _phoneController.text.trim(),
                              description: _descriptionController.text.trim(),
                              status: "En cours",
                              repas_id: selectedRepas!.id.toString(),
                              restaurant_id:
                                  selectedRestaurants?.id?.toString() ?? '',
                              quantite: _quantityController.text.trim(),
                              montant: newPrice.toString(),
                              context: context,
                            );
                          } else if (_nameController.text.isEmpty ||
                              _deliveryAddressController.text.isEmpty ||
                              _phoneController.text.isEmpty ||
                              _quantityController.text.isEmpty ||
                              selectedRepas!.name!.isEmpty) {
                            showMessage(
                              message: 'Certains champs sont obligatoire',
                              context: context,
                            );
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
