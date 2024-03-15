import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCommandeService {
  final requestBaseUrl = AppUrl.httpBaseUrl;

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    // APi url for check commandes
    const String apiUrl = 'https://apiv6.sevenservicesplus.com/api/commandes';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      debugPrint("--------------- response : ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = json.decode(response.body)['data'];
        List<Map<String, dynamic>> infosList =
            List<Map<String, dynamic>>.from(data);
        return infosList;
      } else {
        print("Erreur de la requête HTTP: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("erreur de la requete HTTP: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllLigneCommande() async {
    // APi url for check commandes
    const String apiUrl = 'https://apiv6.sevenservicesplus.com/api/lignecommandes';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      debugPrint("--------------- response : ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = json.decode(response.body)['data'];
        List<Map<String, dynamic>> infosList =
            List<Map<String, dynamic>>.from(data);
        return infosList;
      } else {
        print("Erreur de la requête HTTP: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("erreur de la requete HTTP: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getOrdersByPhoneNumber(
      String phoneNumber) async {
    //Liste pour récupérer toutes les commandes
    List<Map<String, dynamic>> allOrders = await getAllLigneCommande();
    debugPrint("------------------allOrders = ${allOrders.length}");
    // filtrer les commandes en fonction du numéro de Telephone
    List<Map<String, dynamic>> filtredOrders =
        allOrders.where((order) => order['contact'] == null ? true : order['contact'].contains(phoneNumber)).toList();

        debugPrint("------------------filtredOrders = ${filtredOrders.length}");
        

    return filtredOrders;
  }
}
