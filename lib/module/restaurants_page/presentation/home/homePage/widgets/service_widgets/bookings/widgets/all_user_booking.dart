import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class AllUserBookingsPage extends StatefulWidget {
  const AllUserBookingsPage({super.key});

  @override
  State<AllUserBookingsPage> createState() => _AllUserBookingsPageState();
}

class _AllUserBookingsPageState extends State<AllUserBookingsPage> {
  List<dynamic> booking = [];

  final userId = GetStorage().read("userId");

  @override
  void initState() {
    super.initState();
    fetchBookingDatas();
  }

  Future<void> fetchBookingDatas() async {
    final url =
        "https://apiwadounnou.wadounnou.com/api/reservationuser?user_id=$userId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        booking = responseData;
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
              DataColumn(label: Text('Restaurant')),
             // DataColumn(label: Text('Image')),
              DataColumn(label: Text('Adresse / Ville')),
             // DataColumn(label: Text('Spécialité')),
              DataColumn(label: Text('Place(s)')),
            ],
            rows: booking.isEmpty
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
             booking.asMap().entries.map((entry) {
              final int index = entry.key + 1;
              final Map<String, dynamic> bookings = entry.value;

              final String userName = bookings["name"];
              final String restoName = bookings["restaurant"]["name"];
              final String restoImage = bookings["restaurant"]["image_url"];
              final String restoAdresse = bookings["restaurant"]["adresse"];
              final String restoVille = bookings["restaurant"]["ville"];
              final String restoSpecialite =
                  bookings["restaurant"]["specialite"]["name"];
              final String userPlace = bookings["place"];

              return DataRow(cells: [
                DataCell(Text('$index')),
                DataCell(Text(userName)),
                DataCell(Text(restoName)),
                /*DataCell(Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(restoImage), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                )),*/
                DataCell(Text("${restoAdresse}/${restoVille}")),
               // DataCell(Text(restoSpecialite)),
                DataCell(Text(userPlace)),
              ]);
            }).toList(),
          ),
        )
      ],
    );
  }
}
