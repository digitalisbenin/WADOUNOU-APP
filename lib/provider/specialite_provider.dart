
import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/specialites/specialite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class GetSpecialite {
  final requestBaseUrl = AppUrl.baseUrl;

  Future<List<SpecialiteModel>> getSpecialite() async {
    var client = http.Client();
    var specialiteUrl = Uri.https(requestBaseUrl, '/api/specialites');

    try {
      final response = await client.get(specialiteUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData != null && responseData['data'] != null) {
          List<dynamic> specialiteDatas = responseData['data'];
          List<SpecialiteModel> specialiteList = specialiteDatas.map((specialites) => SpecialiteModel.fromJson(specialites)).toList();
          return specialiteList;
        } else {
          return [];
        }
      } else {
        debugPrint('Echec lors du chargement des specialités; statut code : ${response.statusCode}');
        return [];
      }
    } catch(e) {
      debugPrint('Erreur lors de l\'affichage des specialités: $e');
      return [];
    }
    finally {
      client.close();
    }
  }
}