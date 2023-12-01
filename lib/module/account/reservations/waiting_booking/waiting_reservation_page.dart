import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/waiting_booking/widgets/waiting_reservation_listview_body.dart';
import 'package:flutter/material.dart';

class WaitingReservationPage extends StatelessWidget {
  const WaitingReservationPage({super.key});

  static String routeName = '/waiting_reservation_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      /* appBar: AppBar(
            title: const Text(
              "Réservations en attentes",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18.0,
              ),
            )), */
            body: WaitingReservationListviewBody(),
    );
  }
}