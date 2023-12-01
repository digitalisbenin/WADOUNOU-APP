/* 

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Reservations.dart';
import 'package:http/http.dart' as http;

class ReservationService {
  final Map<String, List<Reservations>> _reservations = {};
  final requestBaseUrl = AppUrl.baseUrl;

  void addReservation(String restaurantId, Reservations reservations) {
    if (!_reservations.containsKey(restaurantId)) {
      _reservations[restaurantId] = [];
    }
    _reservations[restaurantId]!.add(reservations);
  }

  List<Reservations> getReservationsForRestaurant(String restaurantId) {
    return _reservations[restaurantId] ?? [];
  }

  bool checkReservationSuccess(String restaurantId, Reservations reservation) {
    // Simulons une logique de vérification basée sur des conditions fictives
    // Vous devez remplacer cela par votre propre logique réelle

    // Supposons que la réservation est considérée comme réussie si le nombre de places est supérieur à zéro
    if (reservation.place! > 0) {
      // La réservation est réussie
      return true;
    } else {
      // La réservation a échoué
      return false;
    }
  }

   /* Future<bool> addReservationToApi(String restaurantId, Reservations reservation) async {
    var client = http.Client();

    final reserveToRestaurantUrl = Uri.https(requestBaseUrl, '/api/restaurant/$restaurantId')
   } */
}
 */