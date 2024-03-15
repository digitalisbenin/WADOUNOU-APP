import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/services/get_reservations.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';

class UsersBookingsPage extends StatefulWidget {
  const UsersBookingsPage({super.key});

  static String routeName = '/users_bookings_page';

  @override
  State<UsersBookingsPage> createState() => _UsersBookingsPageState();
}

class _UsersBookingsPageState extends State<UsersBookingsPage> {
    final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool isButtonClicked = false;

  List<Map<String, dynamic>> reservationsList = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              "Mes Réservations",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
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
        body: SingleChildScrollView(
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
    ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(12)
            ),
            child: AppFilledButton(
              text: "Vérifier",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  checkReservations(_phoneController.text);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Map<String, String> formatDate(String laDate) {
    DateTime dateTime = DateTime.parse(laDate);
    String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    String time = "${dateTime.hour}:${dateTime.minute}";

    return {
      'date': date,
      'time': time,
    };
  }

  Map<String, String> formatDateDeReservation(String laDateDeReservation) {
    DateTime bookingDateTime = DateTime.parse(laDateDeReservation);
    String bookingDate = "${bookingDateTime.day}/${bookingDateTime.month}/${bookingDateTime.year}";

    return {
      'bookingDate' : bookingDate,
    };
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
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (reservationsList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: _buildNoReservationsWidget()),
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
                children: reservationsList.map((reservation) {
                  Map<String, String> dateHeure =
                      formatDate(reservation['date']);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Id: ",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              reservation['id'],
                              maxLines: 2,
                              style: const TextStyle(fontSize: 17.0, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            const Text("Restaurants: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              reservation['restaurant']['name'],
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
                              "Nom du client: ",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              reservation['name'],
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Text("Date et Heure: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              "${dateHeure['date']} à ${dateHeure['time']}",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        const Row(
                          children: [
                            Text("Date de création: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                  reservation['restaurant']['user']['created_at'],
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 17.0, overflow: TextOverflow.ellipsis),
                                ),
                          ],
                        ),
                         const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            const Text("Nombre de place(s) réservée(s): ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              reservation['place'],
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
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
            'Problème de connexion',
            textAlign: TextAlign.center,
          ); // Retourner un conteneur vide tant que le chargement n'est pas terminé
        }
      },
    );
  }

  Widget _buildNoReservationsWidget() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aucunes réservations en raport avec ce numéro.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 8.0),
          // Vous pouvez remplacer cela par un widget plus approprié
        ],
      ),
    );
  }

  checkReservations(String phone) async {
    List<Map<String, dynamic>> filtredReservations =
        await GetReservationService().getReservationsByPhoneNumber(phone);

    setState(() {
      isButtonClicked = true;
      print(filtredReservations);
      reservationsList = filtredReservations;
      print(reservationsList);
    });

    _simulateLoading();
  }

  // Fonction pour simuler le chargement
  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
