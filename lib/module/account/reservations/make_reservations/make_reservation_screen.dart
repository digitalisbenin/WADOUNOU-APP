import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/make_reservations/make_reservation_body.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/selected_role_page/selected_role_screen.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class MakeReservationScreen extends StatefulWidget {
  const MakeReservationScreen({super.key});

  static String routeName = "/make_reservation_screen";

  @override
  State<MakeReservationScreen> createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  final nomUser = GetStorage().read('userName') ?? 'Nom d\'utilisateur';

  final token = GetStorage().read('token');

  final mailUser = GetStorage().read('userMail') ?? 'test@gmail.com';

  String? globalRoleId;

  @override
  void initState() {
    super.initState();
    globalRoleId = GetStorage().read('role_id');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: kOnBoardingBackgroundColor,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Faire une réservation",
          style: TextStyle(color: kWhite, fontWeight: FontWeight.w400),
        ),
        backgroundColor: kOnBoardingBackgroundColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ((token != null && token.isNotEmpty) && globalRoleId != null)
          ? const MakeReservationBody()
          : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        text: "Se connecter",
                        onPressed: () {
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: const LoginPage());
                          /*Navigator.pushNamed(
                                      context, LoginPage.routeName);*/
                        },
                        color: kWhite,
                        txtColor: kPrimaryColor,
                      ),
                    ),
                  ),
                  const Text("ou", style: TextStyle(fontSize: 18)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        text: "S'inscrire",
                        onPressed: () {
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: const SelectedRoleScreen());
                        },
                        color: kPrimaryColor,
                        txtColor: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
