import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final double? amount;
  final String transactionId;
  final Function postOrderCallback;

  SuccessScreen({
    required this.amount,
    required this.transactionId, 
    required this.postOrderCallback,
  });

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 10.0),
           /*  Text(
              'ID de la transaction: $transactionId',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0), */
            ElevatedButton(
              onPressed: () {
                // Add any action you want to perform after payment success
                // For example, navigate to another screen
              //  postOrderCallback();
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
