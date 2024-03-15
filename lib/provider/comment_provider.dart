import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  // setter
  bool _isLoading = false;
  String _resMessage = '';

  // getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void postComment({
    required String name,
    required String content,
    required String repas_id, 
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addCommentUrl = Uri.https(requestBaseUrl, '/api/commentaires');
    var client = http.Client();

    final body = {
      "content" : content,
      "repas_id" : repas_id,
    };
    print(body);

    try {
      var response = await client.post(addCommentUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        _resMessage = "Votre commentaire a été bien envoyé";
        notifyListeners();
        Navigator.pop(context!);
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
