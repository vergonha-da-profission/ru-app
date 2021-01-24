import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "incoming": false,
        "transactionName": 'Ticket',
        "transactionType": 'Restaurante universitário',
        "amount": 2.5,
        "transactionTime": '30 min',
      },
      {
        "incoming": true,
        "transactionName": 'Depósito na carteira',
        "transactionType": 'Cartão de Crédito',
        "amount": 50.0,
        "transactionTime": '60 min',
      },
      {
        "incoming": true,
        "transactionName": 'Depósito na carteira',
        "transactionType": 'Boleto bancário',
        "amount": 10.0,
        "transactionTime": '90 min',
      },
      {
        "incoming": false,
        "transactionName": 'Ticket',
        "transactionType": 'Restaurante universitário',
        "amount": 2.5,
        "transactionTime": '1 dia',
      }
    ];

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // height: MediaQuery.of(context).size.height - size.height,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return _TransactionItem(
                amount: items[index]["amount"],
                transactionName: items[index]["transactionName"],
                transactionTime: items[index]["transactionTime"],
                transactionType: items[index]["transactionType"],
                incoming: items[index]["incoming"],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    Key key,
    bool incoming,
    @required this.amount,
    @required this.transactionName,
    @required this.transactionType,
    @required this.transactionTime,
  })  : this.incoming = incoming ?? true,
        super(key: key);

  final bool incoming;
  final String transactionName;
  final double amount;
  final String transactionType;
  final String transactionTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.transactionName,
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'R\$ ${amount.toStringAsFixed(2).replaceFirst('.', ',')}',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      this.transactionType,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Há ${this.transactionTime}',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      "assets/svg/${incoming ? "incoming_payments" : "outgoing_payments"}.svg",
                      width: 80,
                      color: incoming ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
