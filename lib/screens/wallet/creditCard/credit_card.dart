import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:ru/bloc/credit_card/credit_card_bloc.dart';
import 'package:ru/bloc/wallet/wallet_bloc.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({Key key, this.balance, this.bloc}) : super(key: key);
  final double balance;
  final WalletBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreditCardBloc>(
      create: (context) => CreditCardBloc(),
      child: BlocBuilder<CreditCardBloc, CreditCardState>(
        builder: (context, state) {
          print('state');
          print(state);

          if (state is CreditCardInitial) {
            return CreditCardScreenBody(
              balance: this.balance,
              bloc: this.bloc,
            );
          } else if (state is CreditCardSuccess) {
            return CreditCardScreenBody(
              balance: this.balance,
              bloc: this.bloc,
              showSuccess: true,
            );
          }

          return Container();
        },
      ),
    );
  }
}

class CreditCardScreenBody extends StatefulWidget {
  final double balance;
  final WalletBloc bloc;
  final bool showSuccess;

  const CreditCardScreenBody(
      {Key key, this.balance, this.bloc, bool showSuccess})
      : this.showSuccess = showSuccess ?? false,
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CreditCardScreenBodyState();
  }
}

class CreditCardScreenBodyState extends State<CreditCardScreenBody> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void showAlert(BuildContext context) {
    showDialog(
      useRootNavigator: false,
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            'Sucesso',
            style: TextStyle(fontSize: 30),
          ),
        ),
        content: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "O valor de ${widget.balance} foi adicionado a sua carteira",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  // Navigator.of(context).pop();
                },
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showSuccess)
      Future.delayed(Duration.zero, () => showAlert(context));

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar com cartão'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              cardBgColor: Color(0xFFcad8dd),
              labelCardHolder: 'NOME',
              height: 200,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      numberValidationMessage:
                          'Por favor, insira um número válido',
                      dateValidationMessage: 'Insira uma data valida',
                      cvvValidationMessage: 'Insira um CVV válido',
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Numéro',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vencimento',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      color: const Color(0xff1b447b),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          BlocProvider.of<CreditCardBloc>(context,
                                  listen: false)
                              .add(new CreditCardEventAddFoundsCreditCard(
                            balance: widget.balance,
                          ));
                        } else {}
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
