
import 'package:digitalis_restaurant_app/module/payment_methods/kkiapay_methods/success_screen.dart';
import 'package:flutter/material.dart';

import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';

/* void successCallback(response, context) {
  Navigator.pop(context);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SuccessScreen(
              amount: newPrice ?? 0.0,
              transactionId: response['transactionId'])));
} */

/* const kkiapay = KKiaPay(
    amount: 2000,
    countries: ["BJ"],
    phone: "",
    name: "",
    email: "",
    reason: 'transaction reason',
    data: 'Fake data',
    sandbox: true,
    apikey: 'd81f7db084ba11eea99e794f985e5009',
    callback: successCallback,
    theme: defaultTheme,
    paymentMethods: ["momo","card"]
); */

class KkiapaySample extends StatelessWidget {
  final KKiaPay kkiapay;
  const KkiapaySample({
    Key? key, required this.kkiapay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Methode de paiement Kkiapay"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 500.0,
                height: 100.0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff222F5A)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    'Procéder au paiement',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => kkiapay),
                    );
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}