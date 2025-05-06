import 'dart:convert';
import 'package:digitalis_restaurant_app/core/model/categorie/categorie_model.dart';
import 'package:http/http.dart' as http;

class Categorie {
  final String id;
  final String name;

  Categorie({required this.id, required this.name});

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'],
      name: json['name'],
    );
  }
}

Future<List<Categorie>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://api-wadounnou.api-mon-encadreur.com/api/categorys'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((item) => Categorie.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}