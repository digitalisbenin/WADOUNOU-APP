import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://apiv6.sevenservicesplus.com/api/auth";
  static String apiBaseUrl = "https://apiv6.sevenservicesplus.com/api";
  StorageService storageService = StorageService();


  // GET 

  Future get(String url) async {
    final http.Response response = await http.get(
      Uri.parse(baseUrl + url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ${storageService.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      if(response.statusCode == 403){
        throw Exception('Oups! Vous n\'etes pas autorisé');
      }
      if(response.statusCode == 400){
        throw Exception('Ressource inexistante sur le serveur');
      }
      if(response.statusCode == 500){
        throw Exception('Oups! Veuillez réesayer, quelque chose s\'est mal passée');
      }
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to retrieve resources list.');
    }
  }

  // POST

    Future<dynamic> post(String url, data) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl + url),
      /* headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ${storageService.getToken()}',
      }, */
      body: jsonEncode(data),
    );

   print(response.body);

    if (response.statusCode == 201) {
      // If the server did return a 201 response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      if(response.statusCode == 403){
        throw Exception('Oups! Vous n\'etes pas autorisé');
      }
      if(response.statusCode == 400){
        throw Exception('Ressource inexistante sur le serveur');
      }
      if(response.statusCode == 500){
        throw Exception('Oups! Veuillez réesayer, quelque chose s\'est mal passée');
      }
      // If the server did not return a "200 OK response",
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to retrieve resources list.');
    }
  }

  // PUT

  Future<dynamic> put(url, data) async {
    final http.Response response = await http.put(
      Uri.parse(baseUrl + url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ${storageService.getToken()}',
      },
      body: jsonEncode(data),
    );
    print(data);
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      if(response.statusCode == 403){
        throw Exception('Oups! Vous n\'etes pas autorisé');
      }
      if(response.statusCode == 400){
        throw Exception('Ressource inexistante sur le serveur');
      }
      if(response.statusCode == 500){
        throw Exception('Oups! Veuillez réesayer, quelque chose s\'est mal passée');
      }
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to retrieve resources list.');
    }
  }

  Future<dynamic> delete(String url) async {
    final http.Response response = await http.delete(
      Uri.parse(baseUrl + url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ${storageService.getToken()}',
      },
    );

    if (response.statusCode == 204) {
      // If the server did return a 204 response
      return response.statusCode;
    } else {
      if(response.statusCode == 403){
        throw Exception('Oups! Vous n\'etes pas autorisé');
      }
      if(response.statusCode == 400){
        throw Exception('Ressource inexistante sur le serveur');
      }
      if(response.statusCode == 500){
        throw Exception('Oups! Veuillez réesayer, quelque chose s\'est mal passée');
      }
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to retrieve resources list.');
    }
  }
}
