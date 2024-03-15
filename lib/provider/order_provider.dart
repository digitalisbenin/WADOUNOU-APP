import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/order_items.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant_order_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  final requesBaseUrl = AppUrl.baseUrl;

  // setter
  bool _isLoading = false;
  String _resMessage = '';
  String? _commandeId;
  /* String? _transactionId; */

  // getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  String? get commandeId => _commandeId;
  /* String? get transactionId => _transactionId; */

  /* void sayHello() {
    debugPrint("------------Hello");
  } */

  void postOrder({
    required String name,
    required String adresse,
    required String contact,
    required String description,
    required String status,
    required String repas_id,
    required String restaurant_id,
    required String montant,
    required String quantite,
    String? transactionId,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addOrderUrl = Uri.https(requesBaseUrl, '/api/commandes');

    var client = http.Client();

    final body = {
      "name": name,
      "adresse": adresse,
      "contact": contact,
      "description": description,
      "status": "En attente",
      "repas_id": repas_id,
      "restaurant_id": restaurant_id,
      "montant": montant,
      "quantite": quantite,
    };
    print(body);

    try {
      var response = await client.post(addOrderUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = jsonDecode(response.body);

        var commandeId = res['data']['id'];

        _isLoading = false;
        /* _resMessage = "Votre order à été bien placé"; */
        postOrderToCommandLineBackend(
          quantite: quantite.toString(),
          montant: montant.toString(),
          repas_id: repas_id.toString(),
          commande_id: commandeId.toString(),
        );
        postPaymentMethod(commandeId: commandeId.toString(), transactionId: transactionId.toString());
        notifyListeners();
        // transition vers une page
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }

  void placeOrderFromCart({
    required String name,
    required String address,
    required String contact,
    required String description,
    required String status,
    String? repas_id,
    required String montant,
    required String quantite,
    String? transactionId,
    required List<OrderItem> items,
    BuildContext? context,
  }) async {
    // Effectuer l'envoi des données au backend pour chaque repas dans la liste
    for (var item in items) {
      await sendOrderItemToBackend(item, transactionId);
    }
    notifyListeners();
  }

  Future<void> sendOrderItemToBackend(OrderItem it, String? transactionId) async {
    var addOrderUrl = Uri.https(requesBaseUrl, '/api/commandes');

    var client = http.Client();

    debugPrint("-----adresse  : ${it.adresse}");
    debugPrint("-----name  : ${it.name}");
    debugPrint("-----description  : ${it.description}");
    debugPrint("-----contact  : ${it.contact}");
    debugPrint("-----status  : ${it.status}");

    final body = {
      "name": it.name,
      "adresse": it.adresse,
      "contact": it.contact,
      "description": it.description,
      "repas_id": it.repasId,
      "montant": it.totalPrice,
      "status": 'En attente',
      "quantite": it.quantity,
    };

    try {
      var response = await client.post(addOrderUrl, body: body);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = jsonDecode(response.body);

        var commandeId = res['data']['id'];

        /* print("Commande envoyée avec succès"); */
        postOrderToCommandLineBackend(
          quantite: it.quantity.toString(),
          montant: it.totalPrice.toString(),
          repas_id: it.repasId.toString(),
          commande_id: commandeId.toString(),
        );
        postPaymentMethod(commandeId: commandeId.toString(), transactionId: transactionId.toString());
        debugPrint(res);

        _resMessage = "Votre order à été bien placé";
        notifyListeners();
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        print("Echec");

        debugPrint(res);
        _isLoading = false;

        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      print("Erreur lors de l'envoi de la commande : $e");
      notifyListeners();
    } finally {
      client.close();
    }
  }

  void placeOrderFromRestaurantCart({
    required String name,
    required String address,
    required String contact,
    required String description,
    required String status,
    String? repas_id,
    required String montant,
    required String quantite,
    required List<RestaurantOrderItem> restaurantItems,
    BuildContext? context,
  }) async {
    for (var restaurant in restaurantItems) {
      await sendRestaurantOrderItemToBackend(restaurant);
    }
    notifyListeners();
  }

  Future<void> sendRestaurantOrderItemToBackend(
      RestaurantOrderItem restItem) async {
    var addOrderUrl = Uri.https(requesBaseUrl, '/api/commandes');

    String? transactionId;

    var client = http.Client();

    debugPrint("-----adresse  : ${restItem.adresse}");
    debugPrint("-----name  : ${restItem.name}");
    debugPrint("-----description  : ${restItem.description}");
    debugPrint("-----contact  : ${restItem.contact}");
    debugPrint("-----status  : ${restItem.status}");

    final body = {
      "name": restItem.name,
      "adresse": restItem.adresse,
      "contact": restItem.contact,
      "description": restItem.description,
      "repas_id": restItem.repasId,
      "montant": restItem.totalPrice,
      "status": 'En attente',
      "quantite": restItem.quantity,
    };

    try {
      var response = await client.post(addOrderUrl, body: body);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = jsonDecode(response.body);

        var commandeId = res['data']['id'];

        print("Commande envoyée avec succès");
        debugPrint(res);

        /*  _resMessage = "Votre order à été bien placé"; */
        postOrderToCommandLineBackend(
          quantite: restItem.quantity.toString(),
          montant: restItem.totalPrice.toString(),
          repas_id: restItem.repasId.toString(),
          commande_id: commandeId.toString(),
        );
        postPaymentMethod(commandeId: commandeId.toString(), transactionId: transactionId.toString());
        notifyListeners();
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        debugPrint("Echec");

        debugPrint(res);
        _isLoading = false;

        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      print("Erreur lors de l'envoi de la commande : $e");
      notifyListeners();
    } finally {
      client.close();
    }
  }

  void postQuickOrder({
    required String name,
    required String adresse,
    required String contact,
    required String description,
    required String status,
    required String repas_id,
    required String montant,
    required String quantite,
    String? transactionId,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addOrderUrl = Uri.https(requesBaseUrl, '/api/commandes');

    var client = http.Client();

    final body = {
      "name": name,
      "adresse": adresse,
      "contact": contact,
      "description": description,
      "status": "En attente",
      "repas_id": repas_id,
      "montant": montant,
      "quantite": quantite,
    };
    print(body);

    try {
      var response = await client.post(addOrderUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        var res = jsonDecode(response.body);

        var commandeId = res['data']['id'];
        /* _resMessage = "Votre order à été bien placé"; */
        postOrderToCommandLineBackend(
          quantite: quantite.toString(),
          montant: montant.toString(),
          repas_id: repas_id.toString(),
          commande_id: commandeId.toString(),
        );
        postPaymentMethod(commandeId: commandeId.toString(), transactionId: transactionId.toString());
        notifyListeners();
        // transition vers une page
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        debugPrint(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  void postOrderToCommandLineBackend({
    required String quantite,
    required String montant,
    required String repas_id,
    String? commande_id,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addOrderUrlToCommandLine =
        Uri.https(requesBaseUrl, '/api/lignecommandes');

    var client = http.Client();

    final body = {
      "commande_id": commande_id,
      "repas_id": repas_id,
      "montant": montant,
      "quantite": quantite,
    };
    print(body);

    try {
      var response = await client.post(addOrderUrlToCommandLine, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        _resMessage = "Votre order à été bien placé";
        notifyListeners();
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        debugPrint(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  void quickClear() {
    _resMessage = "";
    notifyListeners();
  }

  void postOrderFromRestaurant({
    required String name,
    required String adresse,
    required String contact,
    required String description,
    required String status,
    required String repas_id,
    required String restaurant_id,
    required String montant,
    required String quantite,
    String? transactionId,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addOrderUrl = Uri.https(requesBaseUrl, '/api/commandes');

    var client = http.Client();

    final body = {
      "name": name,
      "adresse": adresse,
      "contact": contact,
      "description": description,
      "status": 'En attente',
      "repas_id": repas_id,
      "restaurant_id": restaurant_id,
      "montant": montant,
      "quantite": quantite,
    };
    print(body);

    try {
      var response = await client.post(addOrderUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        var res = jsonDecode(response.body);

        var commandeId = res['data']['id'];
        /* _resMessage = "Votre order à été bien placé"; */
        postOrderToCommandLineBackend(
          quantite: quantite.toString(),
          montant: montant.toString(),
          repas_id: repas_id.toString(),
          commande_id: commandeId.toString(),
        );
        postPaymentMethod(commandeId: commandeId.toString(), transactionId: transactionId.toString());
        notifyListeners();
        // transition vers une page
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clearFromRestaurant() {
    _resMessage = "";
    notifyListeners();
  }

  void postPaymentMethod({
    String? transactionId,
    String? commandeId,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addOrderUrlToCommandLine = Uri.https(requesBaseUrl, '/api/payments');

    var client = http.Client();

    final body = {
      "transationId": transactionId,
      "commande_id": commandeId,
    };
    print(body);

    try {
      var response = await client.post(addOrderUrlToCommandLine, body: body);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        jsonDecode(response.body);

        print(response.statusCode);
        print("----------------------------");
        print(response.body);
        notifyListeners();
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        debugPrint(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      print(":::: $e");
    }
  }
}
