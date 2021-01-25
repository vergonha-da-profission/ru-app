import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/wallet/wallet_bloc.dart';
import 'package:ru/screens/wallet/bankSilk/bank_silk.dart';
import 'package:ru/screens/wallet/creditCard/credit_card.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc(),
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return WalletInitial();
        },
      ),
    );
  }
}

class WalletInitial extends StatefulWidget {
  const WalletInitial({
    Key key,
  }) : super(key: key);

  @override
  _WalletInitialState createState() => _WalletInitialState();
}

class _WalletInitialState extends State<WalletInitial> {
  double value;

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
      child: Column(
        children: [
          Text(
            'Quanto	você	deseja	abastecer?',
            style: GoogleFonts.roboto(
              fontSize: 23,
            ),
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: '0,00',
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(
              fontSize: 23,
            ),
            onChanged: (value) {
              try {
                if (double.parse(_controller.text) <= 0 || value == '-') {
                  _controller.clear();
                  return;
                }

                this.value = double.parse(_controller.text);
              } on Exception catch (_) {
                _controller.clear();
              }
            },
            onEditingComplete: () {
              if (double.parse(_controller.text) <= 0) {
                _controller.clear();
              }
            },
          ),
          PaymentArea(getBalance: getValue)
        ],
      ),
    );
  }

  double getValue() {
    return this.value;
  }
}

class PaymentArea extends StatelessWidget {
  const PaymentArea({
    Key key,
    this.getBalance,
  }) : super(key: key);

  final Function getBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              final bloc = BlocProvider.of<WalletBloc>(context, listen: false);
              print(bloc);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreditCardScreen(balance: getBalance(), bloc: bloc),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/svg/card.svg',
              semanticsLabel: 'Card',
              width: 100,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BankSilkScreen(
                          balance: getBalance(),
                          pdfString:
                              '34191.79001 01043.510047 91020.150008 4 85070026000',
                        )),
              );
            },
            child: SvgPicture.asset(
              'assets/svg/bank.svg',
              semanticsLabel: 'Card',
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
