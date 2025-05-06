import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LivreurUploadFileProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<String?> uploadeFiles({
    required String filePath,
    /* BuildContext? context, */
  }) async {
    _isLoading = true;
    notifyListeners();

    final userToken = GetStorage().read("token");

    try {
      var mediaUrl = 'https://api-wadounnou.api-mon-encadreur.com/api/medias';

      var request = http.MultipartRequest("POST", Uri.parse(mediaUrl));
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        filePath,
        /* contentType: MediaType('application', 'x-tar'), */
      ));
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken}',
        "Content-Type": "multipart/form-data",
      });

      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Uploaded!");

        final res = json.decode(await response.stream.bytesToString());

        return res['data']['media_url'];
      }
    } catch (e) {
      _isLoading = false;
      _resMessage = "Réessayez encore";
      notifyListeners();

      print("::::: $e");
    }}

}