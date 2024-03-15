import 'dart:convert';

import 'package:digitalis_restaurant_app/core/model/Users/Categoris.dart';
import 'package:http/http.dart' as http;

class CategoriesList {
  Future<List<Categoris>> categories = getCategories();

  static Future<List<Categoris>> getCategories() async {
    const categoriesUrl = 'https://apiv6.sevenservicesplus.com/api/categorys';

    final response = await http.get(Uri.parse(categoriesUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Categoris>((e) => Categoris.fromJson(e)).toList();
  }

}