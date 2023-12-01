import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:flutter/material.dart';

class SuccessScreenFromRestaurant extends StatelessWidget {
  final double? amount;
  final String transactionId;
  final Function postOrderCallback;

  SuccessScreenFromRestaurant({
    required this.amount,
    required this.transactionId,
    required this.postOrderCallback,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDetailArguments? arguments =
        ModalRoute.of(context)?.settings.arguments as ProductDetailArguments?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Succès'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Paiement réussi !',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Montant: ${amount.toString()} FCFA',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),/* 
            Text(
              'ID de la transaction: $transactionId',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0), */
            ElevatedButton(
              onPressed: () {
                if (arguments != null) {
                  postOrderCallback(arguments);
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: const Text('Fermer'),
            ),
          ],
        ),
      ),
    );
  }
}
