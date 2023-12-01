import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  TextEditingController bankName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    bankName = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            CreditCardWidget(
                customCardTypeIcons: [
                  CustomCardTypeIcon(
                      cardType: CardType.unionpay,
                      cardImage: Image.asset(
                        "assets/images/union.png",
                        height: 30,
                        width: 30,
                      )),
                  CustomCardTypeIcon(
                      cardType: CardType.otherBrand,
                      cardImage: Image.asset(
                        "assets/images/mastercard.png",
                        height: 40,
                        width: 40,
                      )),
                ],
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: bankName.text,
                frontCardBorder: Border.all(color: Colors.grey),
                backCardBorder: Border.all(color: Colors.grey),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: const Color.fromARGB(255, 109, 8, 1),
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand cardBrand) {}),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 17, right: 17, top: 20),
                      child: TextFormField(
                        controller: bankName,
                        style: const TextStyle(color: Colors.white),
                        onEditingComplete: (() => setState(() {})),
                        decoration: InputDecoration(
                          labelText: 'Nom  de la banque',
                          hintText: 'United Bank of Africa (UBA)',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: kTextColor),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                      ),
                    ),
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      inputConfiguration: InputConfiguration(
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Numéro de carte',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: kTextColor),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: kTextColor),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Date d\'expiration',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: kTextColor),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: kTextColor),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Titulaire de la Carte',
                        ),
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: _onValidate,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Colors.purple,
                              Colors.purpleAccent,
                              Colors.deepPurple
                            ],
                            begin: Alignment(-1, -4),
                            end: Alignment(1, 4),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Validate',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      _showValidDialog(
          context, "Valide", "Votre carte est validée avec succès !!!");
    } else {
      _showValidDialog(context, "Non valide", "Essayez encore !!!");
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  _showValidDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }
}
