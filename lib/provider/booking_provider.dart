
import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BookingProvider extends ChangeNotifier {
  // base url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';
  bool _isSuccess = false;

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get isSuccess => _isSuccess;

  void postBooking({
    required String name,
    required String contact,
    required String dateAndTime,
    required String place,
    required String description,
    required String restaurant_id,
    BuildContext? context,
}) async {
    _isLoading = true;
    notifyListeners();

    var addBookingUrl = Uri.https(requestBaseUrl, '/api/reservations');

    var client = http.Client();

    final body = {
      "name": name,
      "contact": contact,
      "date": dateAndTime,
      "place": place,
      "description": description,
      "restaurant_id": restaurant_id
    };
    print(body);

    try {
      var response = await client.post(addBookingUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        _resMessage = "Réservation soumise avec succès";
        _isSuccess = true;
        notifyListeners();
        // transition vers une page
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        _isSuccess = false;
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      _isSuccess = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      _isSuccess = false;
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