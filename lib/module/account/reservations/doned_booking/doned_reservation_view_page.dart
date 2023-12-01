import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/doned_booking/widgets/doned_reservation_listview_body.dart';
import 'package:flutter/material.dart';

class DonedReservationViewPage extends StatelessWidget {
  const DonedReservationViewPage({super.key});

  static String routeName = '/pending_reservation_view_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      /* appBar: AppBar(
            title: const Text(
              "Réervation(s) en cours",
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
            body: DonedReservationListviewBody(),
    );
  }
}