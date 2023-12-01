import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

final _paymentMethodeList = [
  {'title' : 'MTN Mobile Money', 'route': ''},
  {'title' : 'MOOV Money', 'route': ''},
  {'title' : 'Carte Bancaire', 'route': ''},
];

class SubscriptionBody extends StatelessWidget {
  const SubscriptionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),
          const Text('Ajoutez une methode de payement', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
           Flexible(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                key: const ValueKey("payment_method"),
                itemCount: _paymentMethodeList.length,
                separatorBuilder: (_, i) {
                  if (i == -1) {
                    return const SizedBox();
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(),
                  );
                },
                itemBuilder: (_, i) {
                  return ListTile(
                    key: ValueKey("item_${i}_payment_method"),
                    title: Text(
                      _paymentMethodeList[i]['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    ),
                    onTap: () {
                      
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}