import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/doned_delivery_listview_page.dart';
import 'package:flutter/material.dart';

class DoneDeliveryPage extends StatefulWidget {
  const DoneDeliveryPage({super.key});

  static String routeName = "/done_delivery_page";

  @override
  State<DoneDeliveryPage> createState() => _DoneDeliveryPageState();
}

class _DoneDeliveryPageState extends State<DoneDeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackground,
      body: DonedDeliveryListViewPage(),
    );
  }
}
