import 'package:digitalis_restaurant_app/core/model/Users/User.dart';
import 'package:digitalis_restaurant_app/core/services/api_service.dart';
import 'package:http/http.dart' as http;

class RegisterUserService {
  // methode to create a new user
  Future registerUser(Users data) async {
    print(data.toJson());
    final response = await ApiService().post('/register', data.toJson());
    print(response);
    print('réponse du serveur : ${response.statusCode}');

    return response;
  }
}
