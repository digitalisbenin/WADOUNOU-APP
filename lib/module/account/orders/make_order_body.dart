import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Categoris.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/services/get_categories.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/kkiaPay_sample.dart';
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/success_screen.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';

class MakeOrderBody extends StatefulWidget {
  const MakeOrderBody({super.key});

  @override
  State<MakeOrderBody> createState() => _MakeOrderBodyState();
}

class _MakeOrderBodyState extends State<MakeOrderBody> {
  int _numberOfItem = 1;
  double? newPrice;
  String? transactionId;

  String? selectedResto;
  List<String> restaurantNames = [];

  final _formKey = GlobalKey<FormState>();

  Categoris? selectedCategory;
  List<Categoris> categories = [];

  Restaurant? selectedRestaurants;

  Repas? selectedRepas;
  List<Repas> repasItems = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: "1");

  List<DropdownMenuItem<String>> dropdownRestaurantItems = [];

  Map<String, List<Restaurant>> repasByRestaurants = {};

  Future<List<dynamic>> fetchData() async {
    final repas = await RepasList.getRepas();
    final restaurants = await RestaurantList.getRestaurants();
    return [repas, restaurants];
  }

  Future<void> _loadCategories() async {
    final fetchedCategories = await CategoriesList().categories;
    setState(() {
      categories = fetchedCategories;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
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

  void successCallback(response, context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessScreen(
          amount: newPrice ?? 0.0,
          transactionId: response['transactionId'],
          postOrderCallback: postOrder,
        ),
      ),
    );
     Provider.of<OrderProvider>(context, listen: false).postPaymentMethod(
        transactionId: transactionId,
        context: context,
      );
    postOrder();
  }

  void postOrder() {
    // Appeler ordering.postOrder ici avec les données nécessaires
    Provider.of<OrderProvider>(context, listen: false).postOrder(
      name: _nameController.text.trim(),
      adresse: _deliveryAddressController.text.trim(),
      contact: _phoneController.text.trim(),
      description: _descriptionController.text.trim(),
      status: "En cours",
      repas_id: selectedRepas!.id.toString(),
      restaurant_id: selectedRestaurants!.id.toString(),
      quantite: _quantityController.text.trim(),
      montant: newPrice.toString(),
      transactionId: transactionId.toString(),
      context: context,
    );
  }

  Future<bool> openKkiapayPayment() async {
    // Créez une instance KKiaPay avec le montant actuel
    final kkiapay = KKiaPay(
        amount: newPrice?.toInt() ?? 0,
        countries: const ["BJ"],
        phone: _phoneController.text.trim().toString(),
        name: _nameController.text.trim().toString(),
        email: "",
        reason: 'transaction reason',
        data: 'Fake data',
        sandbox: true,
        apikey: 'd81f7db084ba11eea99e794f985e5009',
        callback: successCallback,
        theme: defaultTheme,
        paymentMethods: const ["momo", "card"]);

// Ouvrez l'écran Kkiapay
    final success = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KkiapaySample(kkiapay: kkiapay)),
    );

    return success ?? false;
  }

  Widget _buildCategoriesDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory?.id,
      items: categories.map((category) {
        return DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name!),
        );
      }).toList(),
      onChanged: (value) async {
        final repas = await RepasList().getRepasByCategory(value!);
        setState(() {
          selectedCategory = categories.firstWhere((cat) => cat.id == value);
          if (selectedCategory == null) {
            repasItems = repas;
          } else {
            // Sinon, filtrer les repas par la catégorie sélectionnée
            repasItems =
                repas.where((repas) => repas.categoris!.id == value).toList();
          }
          selectedRepas = null;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Choisissez une catégorie',
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
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner une catégorie';
        }
        return null;
      },
    );
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
                  CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
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
          // final restaurant = snapshot.data!['restaurant'] as List<Restaurant>;

          List<Restaurant> restaurantItems = restaurants;

          List<Repas> repasFiltres;

          if (selectedCategory != null) {
            repasFiltres = repas
                .where((repas) =>
                    repas.categoris != null &&
                    repas.categoris!.id == selectedCategory?.id)
                .toList();
          } else {
            repasFiltres = repas;
          }

          // Créez la liste dropdownItems pour repas avec des valeurs uniques
          final dropdownRepasItems = repasFiltres.map((repas) {
            return DropdownMenuItem<String>(
                value: repas.id, // utilisation de l'id comme valeur
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      repas.name.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    /* const SizedBox(
                      width: 8.0,
                    ),
                    Text("${repas.prix.toString()} FCFA"), */
                  ],
                ));
          }).toList();

          // Créez la liste dropdownItems pour restaurants avec des valeurs uniques
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
            newPrice = (prixAsDouble * _numberOfItem).toInt().toDouble();
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
                    child: _buildCategoriesDropdown(),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),

                    // Dropdown de repas
                    child: DropdownButtonFormField<String>(
                      // utilisation de String comme type de la liste déroulante
                      value: selectedRepas?.id,
                      items: dropdownRepasItems,
                      onChanged: (value) {
                        final selectedRepass = repasFiltres
                            .firstWhere((repas) => repas.id == value);
                        setState(() {
                          selectedRepas = selectedRepass;
                          selectedRestaurants = null;
                          restaurantItems = restaurants
                              .where((element) =>
                                  element.menu != null &&
                                  element.menu!.repasList != null &&
                                  element.menu!.repasList!.any(
                                      (r) => r.name == selectedRepas!.name))
                              .toList();
                          if (selectedRepas!.name != null) {
                            restaurantItems = restaurantItems
                                .where((restaurant) => restaurant.name!
                                    .toLowerCase()
                                    .contains(
                                        selectedRepas!.name!.toLowerCase()))
                                .toList();
                          }
                          print('1- $selectedRepas');
                          print('2- $selectedRepass');
                          print('resto item : ${restaurantItems}');
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

                    // Dropdown du restaurant

                    child: DropdownButtonFormField<String>(
                      // Utilisez String comme type pour la liste déroulante

                      value: selectedRestaurants?.id,
                      items: dropdownRestaurantItems = restaurants
                          .where((restaurant) =>
                              restaurant.menu != null &&
                              restaurant.menu!.repasList != null &&
                              restaurant.menu!.repasList!
                                  .expand((r) => [r.id])
                                  .toList()
                                  .contains(selectedRepas?.id))
                          .map((restaurant) {
                        return DropdownMenuItem<String>(
                          value: restaurant.id,
                          child: Text(restaurant.name.toString()),
                        );
                      }).toList(),
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
                      cursorColor: kPrimaryColor,
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
                      cursorColor: kPrimaryColor,
                      textCapitalization: TextCapitalization.words,
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
                      cursorColor: kPrimaryColor,
                      textCapitalization: TextCapitalization.sentences,
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
                      cursorColor: kPrimaryColor,
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      cursorColor: kPrimaryColor,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText:
                              "Dites nous plus sur la commande (facultatif)",
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final success = await openKkiapayPayment();
                            if (success) {
                              /*  ordering.postOrder(
                                name: _nameController.text.trim(),
                                adresse: _deliveryAddressController.text.trim(),
                                contact: _phoneController.text.trim(),
                                description: _descriptionController.text.trim(),
                                status: "En cours",
                                repas_id: selectedRepas!.id.toString(),
                                restaurant_id: selectedRestaurants!.id.toString(),
                                quantite: _quantityController.text.trim(),
                                montant: newPrice.toString(),
                                context: context,
                              ); */
                              dispose();

                              showMessage(
                                  message: 'Paiement réussi !',
                                  context: context);

                              print('Succes : $success');
                            } else {
                              // Gérer l'échec du paiement
                              showMessage(
                                  message: 'Échec du paiement',
                                  context: context);
                            }
                          } else if (_nameController.text.isEmpty ||
                              _deliveryAddressController.text.isEmpty ||
                              _phoneController.text.isEmpty ||
                              _quantityController.text.isEmpty ||
                              selectedRepas!.name!.isEmpty) {
                            showMessage(
                              message: 'Certains champs sont obligatoire',
                              context: context,
                            );
                            dispose();
                          }
                          ordering.postOrderToCommandLineBackend(
                            quantite: _numberOfItem.toString(),
                            montant: newPrice.toString(),
                            repas_id: selectedRepas!.id.toString(),
                            /* commande_id: arguments.commandes!.id
                                              .toString() */
                          );
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
