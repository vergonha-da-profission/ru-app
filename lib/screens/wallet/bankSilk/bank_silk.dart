import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/bank_silk/bank_silk_bloc.dart';
import 'package:ru/repository/transaction_repository.dart';
import 'package:share/share.dart';

class BankSilkScreen extends StatelessWidget {
  const BankSilkScreen({
    Key key,
    @required this.balance,
  }) : super(key: key);

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar com boleto'),
      ),
      body: BlocProvider<BankSilkBloc>(
        create: (context) =>
            BankSilkBloc()..add(BankSilkEventGenerate(balance)),
        child: BlocBuilder<BankSilkBloc, BankSilkState>(
          builder: (context, state) {
            if (state is BankSilkStateSuccess) {
              return BankWidget();
            } else if (state is BankSilkStateLoading ||
                state is BankSilkState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class BankWidget extends StatelessWidget {
  const BankWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bankSilk =
        BlocProvider.of<BankSilkBloc>(context, listen: false).bankSilk;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: constraints.maxHeight * .05),
                          child: Text(
                            'Boleto Gerado!',
                            style: GoogleFonts.roboto(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Copie a linha digitável abaixo e a pague em um banco ou lotérica',
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Icon(Icons.share_outlined, size: 50),
                              onTap: () {
                                Share.shareFiles(
                                  [bankSilk.path],
                                  text: 'Great picture',
                                );
                              },
                            ),
                            InkWell(
                              child: Icon(
                                Icons.copy_outlined,
                                size: 50,
                              ),
                              onTap: () async {
                                await ClipboardManager.copyToClipBoard(
                                  bankSilk.code,
                                );

                                final snackBar =
                                    SnackBar(content: Text('Texto copiado!'));

                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        _ShowBankSilkCode(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShowBankSilkCode extends StatefulWidget {
  const _ShowBankSilkCode({
    Key key,
  }) : super(key: key);

  @override
  __ShowBankSilkCodeState createState() => __ShowBankSilkCodeState();
}

class __ShowBankSilkCodeState extends State<_ShowBankSilkCode> {
  bool showText = false;
  BankSilk bankSilk;

  @override
  void initState() {
    super.initState();
    bankSilk = BlocProvider.of<BankSilkBloc>(context, listen: false).bankSilk;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          onPressed: () {
            setState(() {
              showText = !showText;
            });
          },
          child: Text(
            !showText ? 'Mostrar' : 'Esconder',
            style: GoogleFonts.roboto(fontSize: 20),
          ),
        ),
        if (showText)
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              bankSilk.code,
              // textAlign: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 25),
            ),
          ),
      ],
    );
  }
}
