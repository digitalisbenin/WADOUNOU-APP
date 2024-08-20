import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchUserRoleId() async {
  final response = await http.get(Uri.parse('https://apiv2.wadounnou.com/api/roles'));

  if (response.statusCode == 200) {
    final List<dynamic> roles = jsonDecode(response.body)['data'];

    for (var role in roles) {
      if (role['name'] == 'User') {
        return role['id'];
      }
    }

    throw Exception('ID du rôle "User" non trouvé dans la réponse de l\'API');
  } else {
    throw Exception('Échec du chargement des rôles depuis l\'API');
  }
}

Future<String> fetchLivreurRoleId() async {
  final response = await http.get(Uri.parse('https://apiv2.wadounnou.com/api/roles'));

  if (response.statusCode == 200) {
    final List<dynamic> roles = jsonDecode(response.body)['data'];

    for (var role in roles) {
      if (role['name'] == 'Livreur') {
        return role['id'];
      }
    }

    throw Exception('ID du rôle "Livreur" non trouvé dans la réponse de l\'API');
  } else {
    throw Exception('Échec du chargement des rôles depuis l\'API');
  }
}

Future<String> fetchRestaurantRoleId() async {
  final response = await http.get(Uri.parse('https://apiv2.wadounnou.com/api/roles'));

  if (response.statusCode == 200) {
    final List<dynamic> roles = jsonDecode(response.body)['data'];

    for (var role in roles) {
      if (role['name'] == 'Restaurant') {
        return role['id'];
      }
    }

    throw Exception('ID du rôle "Restaurant" non trouvé dans la réponse de l\'API');
  } else {
    throw Exception('Échec du chargement des rôles depuis l\'API');
  }
}


