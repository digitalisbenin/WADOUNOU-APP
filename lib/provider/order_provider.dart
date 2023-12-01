import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  final requesBaseUrl = AppUrl.baseUrl;

  // setter
  bool _isLoading = false;
  String _resMessage = '';

  // getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void postOrder({
    required String name,
    required String adresse,
    required String contact,
    required String description,
    required String status,
    required String repas_id,
    required String restaurant_id,
    required String montant,
    required String quantite,
    BuildContext? context,
}) async {
    _isLoading = true;
    notifyListeners();
    
    var addOrderUrl = Uri.https(requesBaseUrl, '/api/commandes');

    var client = http.Client();

    final body = {
      "name": name,
      "adresse": adresse,
      "contact": contact,
      "description": description,
      "status": status,
      "repas_id": repas_id,
      "restaurant_id": restaurant_id,
      "montant": montant,
      "quantite": quantite,
    };
    print(body);

    try {
      var response = await client.post(addOrderUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        _resMessage = "Votre order à été bien placé";
        notifyListeners();
        // transition vers une page
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }
  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

}