import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/orders/widgets/all_user_lineOrder.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AllUserOrdersBodyPage extends StatefulWidget {
  const AllUserOrdersBodyPage({super.key});

  @override
  State<AllUserOrdersBodyPage> createState() => _AllUserOrdersBodyPageState();
}

class _AllUserOrdersBodyPageState extends State<AllUserOrdersBodyPage> {
  List<dynamic> ordersLine = [];

  final userId = GetStorage().read("userId");

  @override
  void initState() {
    super.initState();
    fetchOrdersData();
  }

  Future<void> fetchOrdersData() async {
    final url = "https://apiv2.wadounnou.com/api/commandeuser?user_id=$userId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        ordersLine = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Date')),
            //  DataColumn(label: Text('Nom du client')),

              DataColumn(label: Text('Restaurant')),
             // DataColumn(label: Text('Spécialité')),
             // DataColumn(label: Text('Adresse')),

             // DataColumn(label: Text('Ville')),
             // DataColumn(label: Text('Quartier')),
              DataColumn(label: Text('Status')),

              DataColumn(label: Text("Détails"))
            ],
            rows: ordersLine.asMap().entries.map((entry) {
              final int index = entry.key + 1;
              final Map<String, dynamic> order = entry.value;

              final String commandeId = order["id"];

              final String commandeDate = formatDate(order["created_at"]);
             // final String customerName = order["name"] ?? 'N/A';
              final String restoName = order["restaurant"]?["name"] ?? 'N/A';
             // final String speciality = order["restaurant"]?["specialite"]?["name"] ?? 'N/A';
             // final String address = order["restaurant"]?["adresse"] ?? 'N/A';
             // final String city = order["restaurant"]?["ville"] ?? 'N/A';
             // final String quarter = order["restaurant"]?["quatier"] ?? 'N/A';
              final String deliveryStatus = order["status"] ?? 'N/A';

              return DataRow(cells: [
                DataCell(Text('$index')),
                DataCell(Text(commandeDate)),
               // DataCell(Text(customerName)),
                DataCell(Text(restoName)),

               // DataCell(Text(speciality)),
               // DataCell(Text(address)),
               // DataCell(Text(city)),

               // DataCell(Text(quarter)),
                DataCell(Text(deliveryStatus)),
                
                DataCell(TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllUserLineOrdersBody(commandeId: commandeId,)));
                }, child: const Text("Voir plus", style: TextStyle(color: kPrimaryColor),)))
              ]);
            }).toList(),
          ),
        )
      ],
    );
  }
}
