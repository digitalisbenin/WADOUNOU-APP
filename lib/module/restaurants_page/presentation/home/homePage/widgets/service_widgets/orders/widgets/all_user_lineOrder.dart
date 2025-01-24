import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AllUserLineOrdersBody extends StatefulWidget {
  const AllUserLineOrdersBody({super.key, this.commandeId});

  final String? commandeId;

  @override
  State<AllUserLineOrdersBody> createState() => _AllUserLineOrdersBodyState();
}

class _AllUserLineOrdersBodyState extends State<AllUserLineOrdersBody> {
  List<dynamic> ordersLine = [];

  @override
  void initState() {
    super.initState();
    fetchOrdersLineData();
  }

  Future<void> fetchOrdersLineData() async {
    final url =
        "https://apiwadounnou.wadounnou.com/api/lignecommandeid?commande_id=${widget.commandeId}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      print(responseData);
      print(widget.commandeId);
      setState(() {
        ordersLine = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOnBoardingBackgroundColor,
        title: const Text(
          'Détails Commandes',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No.')),
                // DataColumn(label: Text('Photo du mets')),
                DataColumn(label: Text('Repas')),

                // DataColumn(label: Text('Categorie')),
                DataColumn(label: Text('Prix')),
                DataColumn(label: Text('Quantité')),

                DataColumn(label: Text('Montant')),
                // DataColumn(label: Text('Adresse de livraison')),
                // DataColumn(label: Text('Status de la livraison')),
              ],
              rows: ordersLine.isEmpty
    ? [
        DataRow(cells: [
          DataCell(Text('')),
          DataCell(Text(
            "Aucune donnée disponible",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey,fontSize: 20),
          )),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
        
        ])
      ]
    :
              
               ordersLine.asMap().entries.map((entry) {
                final int index = entry.key + 1;
                final Map<String, dynamic> order = entry.value;

                final String mealPhoto = order["repas"]["image_url"];
                final String mealName = order["repas"]["name"];
                final String mealCategorie =
                    order["repas"]["categoris"]["name"];
                final String mealPrice = order["repas"]["prix"];
                final String mealQuantity = order["quantite"];
                final String mealAmount = order["montant"];
                final String deliveryAddress = order["commande"]["adresse"];
                final String deliveryStatus = order["commande"]["status"];

                return DataRow(cells: [
                  DataCell(Text('$index')),
                  /*DataCell(Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mealPhoto)),
                        borderRadius: BorderRadius.circular(12.0)),
                  )),*/
                  DataCell(Text(mealName)),

                  //  DataCell(Text(mealCategorie)),
                  DataCell(Text(mealPrice)),
                  DataCell(Text(mealQuantity)),

                  DataCell(Text(mealAmount)),
                  // DataCell(Text(deliveryAddress)),
                  // DataCell(Text(deliveryStatus)),
                ]);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
