import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:http/http.dart' as http;

class GetReservationService {
  final requestBaseUrl = AppUrl.httpBaseUrl;

  Future<List<Map<String, dynamic>>> getAllReservations() async {
    // APi url for check reservations
    final String apiUrl =
        'https://apiv6.sevenservicesplus.com/api/reservations';
    try {
      final response = await http.get(Uri.parse(apiUrl));
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

  Future<List<Map<String, dynamic>>> getReservationsByPhoneNumber(
      String phoneNumber) async {
    //Liste pour récupérer toutes les résservations
    List<Map<String, dynamic>> allReservations = await getAllReservations();
    // filtrer les réservations en fonction du numéro de Telephone
    List<Map<String, dynamic>> filtredReservations = allReservations
        .where((reservation) => reservation['contact'] == phoneNumber)
        .toList();

    return filtredReservations;
  }
}
