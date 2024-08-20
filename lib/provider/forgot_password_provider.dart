import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/widgets/password_reset_mail_send.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ForgotPasswordProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  // setter
  bool _isLoading = false;
  String _resMessage = '';

  // getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void sendEmailForResetPassword({
    required String email,
    BuildContext? context
}) async {
    _isLoading = true;
    notifyListeners();

    var passwordResetUrl = Uri.https(requestBaseUrl, '/api/auth/password/email');
    var client = http.Client();

    final body = {
      "email": email,
    };
    debugPrint("$body");

    try {
      var response = await client.post(passwordResetUrl, body: body);
      debugPrint('${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        _resMessage = "eMail envoyé avec succès";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const PasswordResetMailSent());
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];

        print("res $res");
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet disponible";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Rééssayez encore";
      print("reponse ::::::: $e");
      notifyListeners();
      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}