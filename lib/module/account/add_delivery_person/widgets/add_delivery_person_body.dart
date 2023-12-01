import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Deliver_person/deliver_person.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/account/delivery_list_view/delivery_person_listview_page.dart';
import 'package:flutter/material.dart';

class AddDeliveryPersonBody extends StatefulWidget {
  AddDeliveryPersonBody(
      {super.key, required this.deliverPerson, required this.press});

  final DeliverPerson deliverPerson;
  final GestureTapCallback press;

  @override
  State<AddDeliveryPersonBody> createState() => _AddDeliveryPersonBodyState();
}

class _AddDeliveryPersonBodyState extends State<AddDeliveryPersonBody> {
  List<DeliverPerson> selectedDeliverPersons = [];
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: demoDeliverPerson.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: SizeConfig.screenHeight * 0.085,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2.0,
                        offset: const Offset(0, 0)),
                  ]),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(demoDeliverPerson[index].imageUrlPath),
                  radius: 20,
                ),
                title: Text('${demoDeliverPerson[index].fullName}'),
                trailing: Checkbox(
                    value: demoDeliverPerson[index].isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        demoDeliverPerson[index].isChecked = value!;
                        updateButtonStatus();
                      });
                    }),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
            onPressed: isButtonEnabled ? () => _addDeliverPerson() : null,
            child: const Text(
              "Ajouter à ma liste de livreurs",
              style: TextStyle(color: kWhite),
            )),
      ),
    );
  }

  void updateButtonStatus() {
    setState(() {
      isButtonEnabled = demoDeliverPerson.any((person) => person.isChecked);
    });
  }

  void _addDeliverPerson() {
    /* List<DeliverPerson> selectedDeliverPerson =
        demoDeliverPerson.where((person) => person.isChecked).toList();
    print('Livreur sélectionné : $selectedDeliverPerson'); */
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DeliveryPersonListviewPage(
              selectedDeliverPersons: selectedDeliverPersons,
            )));
  }
}
