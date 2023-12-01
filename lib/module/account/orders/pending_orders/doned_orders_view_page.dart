import 'package:digitalis_restaurant_app/module/account/orders/pending_orders/widgets/doned_orders_listview_body.dart';
import 'package:flutter/material.dart';

class DonedOrdersViewPage extends StatelessWidget {
  const DonedOrdersViewPage({super.key});

  static String routeName = '/pending_orders_view_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
            title: const Text(
              "Commandes en cours",
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
            body: DonedOrdersListviewBody(),
    );
  }
}