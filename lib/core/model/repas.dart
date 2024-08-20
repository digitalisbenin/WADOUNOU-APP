
import 'dart:convert';

import 'package:digitalis_restaurant_app/core/model/Users/Menu.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:http/http.dart' as http;


class RepasList {

  Future<List<Repas>> repas = getRepas();

  static Future<List<Repas>> getRepas() async {

    const repasUrl = 'https://apiv2.wadounnou.com/api/repas';

    final response = await http.get(Uri.parse(repasUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Repas>((e) => Repas.fromJson(e)).toList();
  }

   Future<List<Repas>> getRepasByCategory(String categoryId) async {
    final response = await http.get(
      Uri.parse('https://apiv2.wadounnou.com/api/repas?category_id=$categoryId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('data')) {
        final List<dynamic> repasData = data['data'];
        List<Repas> repas = repasData.map((item) => Repas.fromJson(item)).toList();
        return repas;
      } else {
        throw Exception("La clé 'data' est manquante dans la réponse JSON");
      }
    } else {
      throw Exception('Erreur lors de la récupération des repas par catégorie');
    }
  }

   Future<List<Repas>> getRepasByRestaurant(String restaurantId) async {
    const repasUrl = 'https://apiv2.wadounnou.com/api/repas?restaurant_id=';
    final response = await http.get(Uri.parse('$repasUrl$restaurantId'));
    final body = jsonDecode(response.body);
    return body['data'].map<Repas>((e) => Repas.fromJson(e)).toList();
  }


Future<List<Repas>> getRepasByRestaurantId(String restaurantId)async{
  const String apiUrl = 'https://apiv2.wadounnou.com/api/repas';

  try{
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode ==200 || response.statusCode == 201){
      final List<dynamic> jsonData = json.decode(response.body);
      List<Repas> restaurantMenu = [];

      for(var item in jsonData){
        restaurantMenu.add(Repas.fromJson(item));
      }
      return restaurantMenu;
    }else {
      throw Exception('Echec de la requete API');
    }
  }catch(e){
    throw Exception('Erreur lors de la requperation du menu: $e');
  }
}

// Dqns le fontend tu fera ceci

mafonction() async { 
  String jenesaispasauoimettre = '';
  try {
    List<Repas> menu = await getRepasByRestaurantId(jenesaispasauoimettre);
    for(Repas repas in menu){
      print('Nom du repas: ${repas.name}, Prix: ${repas.prix}');
    }
  }catch (e){
    print('Erreur: $e');
  }
  }

}