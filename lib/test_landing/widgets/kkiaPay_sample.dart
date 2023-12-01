import 'package:digitalis_restaurant_app/test_landing/widgets/success_screen.dart';
import 'package:flutter/material.dart';

import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';

void successCallback(response, context) {
  Navigator.pop(context);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SuccessScreen(
              amount: response['amount'],
              transactionId: response['transactionId'])));
}

const kkiapay = KKiaPay(
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
);

class KkiapaySample extends StatelessWidget {
  const KkiapaySample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KkiPay Payement Methods"),
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
                    'Commencer le paiement',
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