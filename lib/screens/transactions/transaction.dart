import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _transactions =
        BlocProvider.of<AuthenticationBloc>(context, listen: false)
            .user
            .transactions;

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: _transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return _TransactionItem(
                amount: _transactions[index].price,
                transactionName: _transactions[index].name,
                transactionTime: _transactions[index].parsedDate,
                transactionType: _transactions[index].description,
                incoming: _transactions[index].type == "incoming",
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
                      this.transactionTime,
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
