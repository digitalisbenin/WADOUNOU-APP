/* import 'package:digitalis_restaurant_app/test_landing/widgets/fedaPay_sample.dart';
import 'package:digitalis_restaurant_app/test_landing/widgets/kkiaPay_sample.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}



class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payemnt Methods',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Methods'),
          centerTitle: true,
        ),
        body: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const KkiapaySample()));
          }, child: const Text("KkiaPay"),),

          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Accueil()));
          }, child: const Text("FedaPay"),)
        ],
      ),
    );
  }
}

 */