import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/success_screen_from_restaurant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kkiapay_flutter_sdk/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/kkiaPay_sample.dart';
import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';

Future<List<Repas>> fetchRepasByCategory(String categoryId) async {
  final response = await http.get(Uri.parse(
      'https://apiwadounnou.wadounnou.com/api/repascategory?categoris_id=$categoryId'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((e) => Repas.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load category');
  }
}

class RepasScreen extends StatefulWidget {
  final String categoryId;

  const RepasScreen({super.key, required this.categoryId});

  @override
  State<RepasScreen> createState() => _RepasScreenState();
}

class _RepasScreenState extends State<RepasScreen> {
  late Future<List<Repas>> _repas;

  @override
  void initState() {
    super.initState();
    _repas = fetchRepasByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _repas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun repas pour le moment'));
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('Erreur lors du chargement des repas'));
          }

          final repas = snapshot.data!;

          return ListView.builder(
            itemCount: repas.length,
            itemBuilder: (context, index) {
              final repa = repas[index];
              return Padding(
                padding: EdgeInsets.all(SizeConfig.screenWidth * 0.01),
                child: BuildMealCard(
                  repas: repa,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      ItemDetailsPage.routeName,
                      arguments: ProductDetailArguments(
                        repas: repa,
                      ),
                    );
                  },
                ),
              );
            },
          );
        });
  }
}

class BuildMealCard extends StatefulWidget {
  final Repas repas;
  final GestureTapCallback press;

  const BuildMealCard({super.key, required this.repas, required this.press});

  @override
  State<BuildMealCard> createState() => _BuildMealCardState();
}

class _BuildMealCardState extends State<BuildMealCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        width: SizeConfig.screenWidth * 0.44,
        height: SizeConfig.screenHeight * 0.15,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12),
            border: const Border.fromBorderSide(
                BorderSide(color: kTextColor, width: 0.3)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0))
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: SizeConfig.screenHeight * 0.12,
                width: SizeConfig.screenWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: const Border.fromBorderSide(
                        BorderSide(color: kTextColor, width: 0.3)),
                    image: DecorationImage(
                        image: NetworkImage(widget.repas.image_url ?? ''),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.35,
                    child: Text(
                      widget.repas.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.010,
                  ),
                  Text(
                    "${double.parse(widget.repas.prix ?? '0').toStringAsFixed(0)} FCFA",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.010,
                  ),
                  Text(
                      widget.repas.categoris!.name.toString() ??
                          'Pas de categorie',
                      style:
                          const TextStyle(fontSize: 14, color: kYellowColor)),
                ],
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.10,
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: SizeConfig.screenHeight * 0.026,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RepasDetailPage extends StatefulWidget {
  final Repas repas;

  const RepasDetailPage({super.key, required this.repas});

  @override
  State<RepasDetailPage> createState() => _RepasDetailPageState();
}

class _RepasDetailPageState extends State<RepasDetailPage> {
  double newPrice = 0.0;
  int _numberOfItem = 1;
  String? transactionId;

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
    double price = double.tryParse(widget.repas.prix ?? "") ?? 0.0;

    newPrice = price * _numberOfItem;
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            widget.repas.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
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
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.repas.image_url ?? ''),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.04),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            "${(newPrice).toStringAsFixed(0)} FCFA",
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
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.6,
                              child: Text(
                                widget.repas.name.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 23.5,
                                    fontWeight: FontWeight.bold),
                              ),
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
                                        color: kPrimaryColor.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(5)),
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
                                        borderRadius: BorderRadius.circular(5)),
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
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        widget.repas.description.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: kYellowColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.15,
                    ),
                    AppFilledButton(
                      text: "Commander ce repa",
                      onPressed: () {
                        String repasId = widget.repas.id ?? "";
                        print("ID du repas sélectionné : $repasId");
                        _showBottomSheet(context);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.06,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    void postQuickOrder() {
      Provider.of<OrderProvider>(context, listen: false).postQuickOrder(
        name: _nameController.text.trim(),
        adresse: _addressController.text.trim(),
        contact: _contactController.text.trim(),
        description: _descriptionController.text.trim(),
        status: "En attente",
        repas_id: widget.repas.id.toString(),
        quantite: _numberOfItem.toString(),
        montant: newPrice.toString(),
        transactionId: transactionId.toString(),
        context: context,
      );
    }

    void successCallback(response, context) {
      transactionId = response['transactionId'];
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreenFromRestaurant(
            amount: newPrice,
            transactionId: transactionId.toString(),
            postOrderCallback: postQuickOrder,
          ),
        ),
      );
      Provider.of<OrderProvider>(context, listen: false).postPaymentMethod(
        transactionId: transactionId,
        context: context,
      );
      postQuickOrder();
    }

    Future<bool> openKkiapayPayment() async {
      final kkiapay = KKiaPay(
          amount: newPrice.toInt(),
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
                                          value.length == 10 ||
                                          value.length == 12 ||
                                          value.length == 13 ||
                                          value.length == 15) {
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
                                Consumer<OrderProvider>(
                                    builder: (context, quickOrder, child) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (quickOrder.resMessage != '') {
                                      showMessage(
                                          message: quickOrder.resMessage,
                                          context: context);
                                      quickOrder.quickClear();
                                    }
                                  });
                                  return AppFilledButton(
                                    text: "Commander maintenant !",
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();

                                        String? repasId = widget.repas.id;
                                        String? restaurantId =
                                            widget.repas.restaurant!.id;
                                        print(
                                            'ID du repas sélectionné : $repasId');

                                        print(
                                            'ID du restaurant sélectionné : $restaurantId');

                                        quickOrder.postOrderFromRestaurant(
                                            name: _nameController.text.trim(),
                                            adresse:
                                                _addressController.text.trim(),
                                            contact:
                                                _contactController.text.trim(),
                                            description: _descriptionController
                                                .text
                                                .trim(),
                                            status: 'En attente',
                                            repas_id:
                                                widget.repas.id!.toString(),
                                            restaurant_id: widget
                                                .repas.restaurant!.id
                                                .toString(),
                                            montant: newPrice.toString(),
                                            quantite: _numberOfItem.toString(),
                                            context: context);

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                insetPadding:
                                                const EdgeInsets.all(10),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: kWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed: () {
                                                                    ScaffoldMessenger.of(
                                                                        context)
                                                                        .showSnackBar(const SnackBar(
                                                                        content:
                                                                        Text('Votre commande est bien reçue et est en cours de traitement')));
                                                                    PageNavigator(
                                                                        ctx:
                                                                        context)
                                                                        .nextPageOnly(
                                                                        page:
                                                                        const HomeScreen());
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .cancel_outlined)),
                                                            ],
                                                          ),
                                                          /*Center(
                                                        child: Text(arguments.repas.restaurant!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                                      ),*/
                                                          Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  if (widget.repas.restaurant!.mtnpay == "")
                                                                    Row(
                                                                      children: [
                                                                        Text("MTN : Non disponible", style: TextStyle(fontSize: SizeConfig.screenHeight * 0.02),),
                                                                      ],
                                                                    ),
                                                                  // MTNPAY
                                                                  if (widget.repas.restaurant!.mtnpay != "")
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Text("MTN : ", style: TextStyle(fontSize: SizeConfig.screenHeight * 0.02),),
                                                                        GestureDetector(
                                                                          onLongPress: () {
                                                                            Clipboard.setData(
                                                                                ClipboardData(text: widget.repas.restaurant!.mtnpay.toString()));
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                content: Text(
                                                                                    'Le code a été copié dans le presse-papier')));
                                                                          },
                                                                          child: SelectableText(
                                                                            widget.repas.restaurant!.mtnpay.toString(),
                                                                            style: TextStyle(
                                                                                fontSize: SizeConfig.screenHeight * 0.02,
                                                                                color: kPrimaryColor,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 5.0,),
                                                                        IconButton(onPressed: () {
                                                                          Clipboard.setData(
                                                                              ClipboardData(text: widget.repas.restaurant!.mtnpay.toString()));
                                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              content: Text(
                                                                                  'Le code a été copié dans le presse-papier')));
                                                                        }, icon: const Icon(Icons.copy)),
                                                                        /*ElevatedButton(onPressed: () {}, child: const Row(
                                                                    children: [
                                                                      Icon(Icons.copy),
                                                                      Text("COPIER"),
                                                                    ],
                                                                  ))*/
                                                                      ],
                                                                    ),
                                                                  if (widget.repas.restaurant!.moovpay == "")
                                                                    Row(
                                                                      children: [
                                                                        Text("MOOV : Non disponible", style: TextStyle(fontSize: SizeConfig.screenHeight * 0.02),),
                                                                      ],
                                                                    ),
                                                                  // MOOVPAY
                                                                  if (widget.repas.restaurant!.moovpay != "")
                                                                    Row(
                                                                      children: [
                                                                        Text("MOOV : ", style: TextStyle(fontSize: SizeConfig.screenHeight * 0.02),),
                                                                        GestureDetector(
                                                                          onLongPress: () {
                                                                            Clipboard.setData(
                                                                                ClipboardData(text: widget.repas.restaurant!.moovpay.toString()));
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                content: Text(
                                                                                    'Le code a été copié dans le presse-papier')));
                                                                          },
                                                                          child: SelectableText(
                                                                            widget.repas.restaurant!.moovpay.toString(),
                                                                            style: TextStyle(
                                                                                fontSize: SizeConfig.screenHeight * 0.02,
                                                                                color: kPrimaryColor,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 5.0,),
                                                                        IconButton(onPressed: () {
                                                                          Clipboard.setData(ClipboardData(text: widget.repas.restaurant!.moovpay.toString()));
                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                            const SnackBar(content: Text('Le code a été copié dans le presse-papier')),
                                                                          );
                                                                        }, icon: const Icon(Icons.copy)),
                                                                      ],
                                                                    ),
                                                                  if (widget.repas.restaurant!.celtispay == "")
                                                                    Row(
                                                                      children: [
                                                                        Text("CELTIIS : Non disponible", style: TextStyle(fontSize: SizeConfig.screenHeight * 0.02),),
                                                                      ],
                                                                    ),
                                                                  // CELTIISPAY
                                                                  if (widget.repas.restaurant!.celtispay != "")
                                                                    Row(
                                                                      children: [
                                                                        Text("CELTIIS : ", style: TextStyle(fontSize: SizeConfig.screenHeight * 0.02),),
                                                                        GestureDetector(
                                                                          onLongPress: () {
                                                                            Clipboard.setData(
                                                                                ClipboardData(text: widget.repas.restaurant!.celtispay.toString()));
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                content: Text(
                                                                                    'Le code a été copié dans le presse-papier')));
                                                                          },
                                                                          child: SelectableText(
                                                                            widget.repas.restaurant!.celtispay.toString(),
                                                                            style: TextStyle(
                                                                                fontSize: SizeConfig.screenHeight * 0.02,
                                                                                color: kPrimaryColor,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 5.0,),
                                                                        IconButton(onPressed: () {
                                                                          Clipboard.setData(
                                                                              ClipboardData(text: widget.repas.restaurant!.celtispay.toString()));
                                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              content: Text(
                                                                                  'Le code a été copié dans le presse-papier')));
                                                                        }, icon: const Icon(Icons.copy))
                                                                      ],
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });

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
                                      quickOrder.postOrderToCommandLineBackend(
                                        quantite: _numberOfItem.toString(),
                                        montant: newPrice.toString(),
                                        repas_id: widget.repas.id!.toString(),
                                      );
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
}
