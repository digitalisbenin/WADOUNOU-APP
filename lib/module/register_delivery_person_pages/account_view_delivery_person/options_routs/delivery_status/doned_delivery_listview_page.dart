import 'package:flutter/material.dart';

class DonedDeliveryListViewPage extends StatefulWidget {
  const DonedDeliveryListViewPage({super.key});

  @override
  State<DonedDeliveryListViewPage> createState() => _DonedDeliveryListViewPageState();
}

class _DonedDeliveryListViewPageState extends State<DonedDeliveryListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("Terminées"),));
  }
}
