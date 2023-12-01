import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/delivery_pending_listview_page.dart';
import 'package:flutter/material.dart';

class PendingDeliveryPage extends StatefulWidget {
  const PendingDeliveryPage({super.key});

  static String routeName = "/pending_delivery_page";

  @override
  State<PendingDeliveryPage> createState() => _PendingDeliveryPageState();
}

class _PendingDeliveryPageState extends State<PendingDeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackground,
      body: DeliveryPendingListViewPage(),
    );
  }
}
