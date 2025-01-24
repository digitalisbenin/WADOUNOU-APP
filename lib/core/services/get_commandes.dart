import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCommandeService {
  final requestBaseUrl = AppUrl.httpBaseUrl;

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    // APi url for check commandes
    const String apiUrl = 'https://apiwadounnou.wadounnou.com/api/lignecommandes';

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
    const String apiUrl = 'https://apiwadounnou.wadounnou.com/api/lignecommandes';

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

  Future<List<Map<String, dynamic>>> getOrdersByPhoneNumber(String phoneNumber) async {
  // Liste pour récupérer toutes les commandes
  List<Map<String, dynamic>> allOrders = await getAllLigneCommande();
  debugPrint("------------------allOrders = ${allOrders.length}");
  
  // Filtrer les commandes en fonction du numéro de téléphone
  List<Map<String, dynamic>> filtredOrders = allOrders.where((order) {
    // Vérifier si la clé "contact" contient le numéro de téléphone saisi
    if (order['commande']['contact'] != null && order['commande']['contact'].toString().contains(phoneNumber)) {
      // Assurer que le numéro de téléphone est identique, en supprimant les espaces et en le comparant en minuscules
      // Cela garantit que les différences mineures dans la saisie (comme les espaces en trop) ne provoqueront pas de non-correspondance
      return order['commande']['contact'].toString().replaceAll(RegExp(r'\s+'), '') == phoneNumber.replaceAll(RegExp(r'\s+'), '');
    }
    return false; // Ne pas inclure cette commande dans les résultats filtrés
  }).toList();

  debugPrint("------------------filtredOrders = ${filtredOrders.length}");
  return filtredOrders;
}


 /*  Future<List<Map<String, dynamic>>> getOrdersByPhoneNumber(
      String phoneNumber) async {
    //Liste pour récupérer toutes les commandes
    List<Map<String, dynamic>> allOrders = await getAllOrders();
    debugPrint("------------------allOrders = ${allOrders.length}");
    // filtrer les commandes en fonction du numéro de Telephone
    List<Map<String, dynamic>> filtredOrders =
        allOrders.where((order) => order['contact'] == null ? true : order['contact'].contains(phoneNumber)).toList();

        debugPrint("------------------filtredOrders = ${filtredOrders.length}");
        

    return filtredOrders;
  } */
}
