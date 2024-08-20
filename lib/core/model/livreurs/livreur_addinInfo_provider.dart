import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LivreurAddingInfoProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  void addLivreurInfo({
    required String name,
    required String description,
    required String adresse,
    required String phone,
    required String position,
    required String image_url,
    required String document_url,
    required String status,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final userToken = GetStorage().read('token');
    final userId = GetStorage().read('userId');

    var uploadLivreurInfo = Uri.https(requestBaseUrl, '/api/livreurs');

    var client = http.Client();

    final body = {
      "user_id": userId,
      "name": name,
      "description": description,
      "adresse": adresse,
      "phone": phone,
      "position": position,
      "image_url": image_url,
      "document_url": document_url,
      "status": status,
    };

    debugPrint('réponse du body ::: $body');

    try {
      var request = await client.post(uploadLivreurInfo, body: body, headers: {
        'Authorization': 'Bearer $userToken',
      });
      print(userToken);
      print(request.statusCode);
      print(request.body);

      if (request.statusCode == 200 || request.statusCode == 201) {
        final res = jsonDecode(request.body);
        final livreurId = res['data']['id'];

        GetStorage().write('livreurId', livreurId);

        debugPrint("id du livreur ::: $livreurId");


        _isLoading = false;
        notifyListeners();

        if (res['success'] == true) {
          /* _resMessage = "Vos informations ont été mises à jour avec succès !"; */
          showMessage(
            message: "Vos informations ont été mises à jour avec succès !",
          );

        //  Navigator.pushNamed(context!, TeacherHomeScreen.routeName);

          notifyListeners();
          /* PageNavigator(ctx: context)
              .nextPageOnly(page: const AddingInfoSuccessScreen()); */
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = "Quelque chose s'est mal passée !";
          notifyListeners();
        }
      } else {
        final res = jsonDecode(request.body);
        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune Connexion Internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Rééssayez encore";
      notifyListeners();

      print("::::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
