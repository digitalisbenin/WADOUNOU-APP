import 'package:flutter/material.dart';

class DeliveryPendingListViewPage extends StatefulWidget {
  const DeliveryPendingListViewPage({super.key});

  @override
  State<DeliveryPendingListViewPage> createState() => _DeliveryPendingListViewPageState();
}

class _DeliveryPendingListViewPageState extends State<DeliveryPendingListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("En Cours"),));
  }
}
