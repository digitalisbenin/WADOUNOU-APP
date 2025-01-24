import 'dart:convert';
import 'package:http/http.dart' as http;

class Speciality {
  final String id;
  final String name;

  Speciality({required this.id, required this.name});

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
      id: json['id'],
      name: json['name'],
    );
  }
}

Future<List<Speciality>> fetchSpecialities() async {
  final response = await http.get(Uri.parse('https://apiwadounnou.wadounnou.com/api/specialites'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    return data.map((e) => Speciality.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load specialities');
  }
}
