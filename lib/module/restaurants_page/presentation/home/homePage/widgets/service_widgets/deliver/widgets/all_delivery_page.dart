import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class AllDeliveryBodyPage extends StatefulWidget {
  const AllDeliveryBodyPage({super.key});

  @override
  State<AllDeliveryBodyPage> createState() => _AllDeliveryBodyPageState();
}

class _AllDeliveryBodyPageState extends State<AllDeliveryBodyPage> {
  List<dynamic> delivery = [];
  String? livreurId;

  final userId = GetStorage().read("userId");

  @override
  void initState() {
    super.initState();
    fetchLivreursById();
    fetchDeliveryDatas();
  }

  Future<void> fetchLivreursById() async {
    final url = "https://apiwadounnou.wadounnou.com/api/livreur?user_id=$userId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        if (responseData.isNotEmpty) {
          // Récupérer l'user_id du premier livreur
          livreurId = responseData[0]['id'];
          print('object user id ::::::::::::: $userId');
          print('object livreur id ::::::::::::: $livreurId');
          GetStorage().write('livreursId', livreurId);
        } else {
          throw Exception('No livreurs found');
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDeliveryDatas() async {
    String livreur_id = GetStorage().read('livreursId');
    final url =
        "https://api-wadounnou.api-mon-encadreur.com/api/livraisonsuser?livreur_id=${livreur_id}";

    print('object :::::::::::::::: $livreur_id');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        delivery = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
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
              DataColumn(label: Text('Client')),
              DataColumn(label: Text('Contact')),
              DataColumn(label: Text('Adresse')),
              DataColumn(label: Text('Montant')),
              DataColumn(label: Text('Restaurant')),
              DataColumn(label: Text('Spécialité')),
              DataColumn(label: Text('Status')),
            ],
            rows: delivery.isEmpty
    ? [
        DataRow(cells: [
          DataCell(Text('', style: TextStyle(fontSize: 16))),
          DataCell(Text(
            "Aucune donnée disponible",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              fontSize: 16, // Taille de police augmentée
            ),
          )),
           // Cellules vides avec style
          DataCell(Text('', style: TextStyle(fontSize: 16))),
          DataCell(Text('', style: TextStyle(fontSize: 16))),
          DataCell(Text('', style: TextStyle(fontSize: 16))),
          DataCell(Text('', style: TextStyle(fontSize: 16))),
          DataCell(Text('', style: TextStyle(fontSize: 16))),
          DataCell(Text('', style: TextStyle(fontSize: 16))),
        ])
      ]:
            
             delivery.asMap().entries.map((entry) {
              final int index = entry.key + 1;
              final Map<String, dynamic> deliver = entry.value;

              final String customerName = deliver["commande"]["name"];
              final String customerContact = deliver["commande"]["contact"];
              final String customerAdresse = deliver["commande"]["adresse"];
              final String Amount = deliver["commande"]["montant"];
              final String restoName = deliver["commande"]["restaurant"]["name"];
              final String restoSpeciality = deliver["commande"]["restaurant"]["specialite"]["name"];
              final String orderStatus = deliver["commande"]["status"];

              return DataRow(cells: [
                DataCell(Text('$index')),
                DataCell(Text(customerName)),
                DataCell(Text(customerContact)),
                DataCell(Text(customerAdresse)),
                DataCell(Text('$Amount FCFA')),
                DataCell(Text(restoName)),
                DataCell(Text(restoSpeciality)),
                DataCell(Text(orderStatus)),
              ]);
            }).toList(),
          ),
        )
      ],
    );
  }
}
