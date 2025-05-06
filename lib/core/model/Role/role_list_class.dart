import 'dart:convert';
import 'package:http/http.dart' as http;

// Fonction pour obtenir les rôles avec les types de retour corrects
Future<List<Map<String, String>>> fetchRoles() async {
  final response = await http.get(Uri.parse('https://api-wadounnou.api-mon-encadreur.com/api/roles'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    final List<Map<String, String>> roles = data.map((role) => {
      'id': role['id'].toString(),
      'name': role['name'].toString()
    }).toList();

    // Filtrer pour ne garder que "User" et "Livreur"
    return roles.where((role) => role['name'] == 'Client' || role['name'] == 'Livreur').toList();
  } else {
    throw Exception('Failed to load roles');
  }
}