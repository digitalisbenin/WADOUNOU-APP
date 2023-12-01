import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/done_delivery_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/pending_deliver_page.dart';
import 'package:flutter/material.dart';

class DeliveryStatusPage extends StatelessWidget {
  const DeliveryStatusPage({super.key});

  static String routeName = "/delivery_status_page";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kBackground,
        appBar: AppBar(
            title: const Text(
              "Status de livraisons",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
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
            ),
          bottom: TabBar(
            onTap: (index) {
              print(index);
            },
            indicatorColor: kPrimaryColor,
            labelColor: kTextColor,
            mouseCursor: SystemMouseCursors.click,
            tabs: [
              Tab(
                text: "En Cours (0)".toUpperCase(),
              ),
              Tab(
                text: 'Terminée(s) (0)'.toUpperCase(),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PendingDeliveryPage(),
            DoneDeliveryPage(),
          ],
        )

      ),
    );
  }
}
