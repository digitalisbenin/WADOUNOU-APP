/* 
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/services/get_commandes.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';

class UsersOrdersBody extends StatefulWidget {
  const UsersOrdersBody({super.key});

  @override
  State<UsersOrdersBody> createState() => _UsersOrdersBodyState();
}

class _UsersOrdersBodyState extends State<UsersOrdersBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  bool isButtonClicked = false;

  List<Map<String, dynamic>> ordersList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isButtonClicked
              ? _buildResultWidget()
              : _buildFormWidget(), // Afficher le champ et le bouton ou le résultat en fonction de l'état
          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),
        ],
      ),
    );
  }

  checkOrders(String phone) async {
    List<Map<String, dynamic>> filtredOrders =
        await GetCommandeService().getOrdersByPhoneNumber(phone);

    setState(() {
      isButtonClicked = true;
      print(filtredOrders);
      ordersList = filtredOrders;
      print(filtredOrders);
    });

    _simulateLoading();
  }

  Widget _buildFormWidget() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                cursorColor: kTextColor,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Numéro de téléphone",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: kTextColor),
                ),
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
            const SizedBox(width: 10.0),
            AppFilledButton(
              text: "Vérifier",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  checkOrders(_phoneController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultWidget() {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(color: kPrimaryColor,),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (ordersList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: _buildNoOrdersWidget()),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Column(
                children: ordersList.map((order) {    
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          "Libellé : Commande",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Nom du client: ",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              order['commande']['name'] ?? "",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Repas: ",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              order['repas']['name'] ?? "",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Text("Prix: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              order['repas']['prix'] ?? "",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Text("Quantité: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              order['quantite'] ?? "",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Text("Montant: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              order['montant'] ?? "",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Divider(
                          thickness: 1.0,
                          endIndent: 25.0,
                          indent: 25.0,
                          height: 2.0,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return const Text(
              'Problème de connexion', textAlign: TextAlign.center,); // Retourner un conteneur vide tant que le chargement n'est pas terminé
        }
      },
    );
  }

  Widget _buildNoOrdersWidget() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aucunes commandes en raport avec ce numéro.", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 8.0),
          // Vous pouvez remplacer cela par un widget plus approprié
        ],
      ),
    );
  }

  // Fonction pour simuler le chargement
  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
 */