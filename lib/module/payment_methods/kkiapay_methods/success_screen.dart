import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: const Text('Paiement effectué avec Succès👍'),
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
              'Montant: ${amount!.toStringAsFixed(0)} FCFA',
              style: const TextStyle(fontSize: 16.0),
            ),
            /* const SizedBox(height: 10.0),
            Text(
              'ID de la transaction: $transactionId',
              style: const TextStyle(fontSize: 16.0),
            ), */
            const SizedBox(height: 20.0),
            Consumer<OrderProvider>(
              builder: (context, sendData, child) {
                return ElevatedButton(
                  onPressed: () {
                    // Add any action you want to perform after payment success
                    // For example, navigate to another screen
                  //  postOrderCallback();
                  String? commandeId = sendData.commandeId;
                  if (commandeId != null) {
                      sendData.postPaymentMethod(
                          transactionId: transactionId.toString(),
                          commandeId: commandeId);
                    }
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: const Text('Fermer'),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
