import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class BankSilkScreen extends StatelessWidget {
  const BankSilkScreen({
    Key key,
    @required this.pdfString,
    @required this.balance,
  }) : super(key: key);

  final String pdfString;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar com boleto'),
      ),
      body: Center(
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
                            margin: EdgeInsets.only(
                                top: constraints.maxHeight * .05),
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
                                  Share.share(
                                    this.pdfString,
                                    subject: 'Seu boleto bancário!',
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
                                    this.pdfString,
                                  );

                                  final snackBar =
                                      SnackBar(content: Text('Texto copiado!'));

                                  Scaffold.of(context).showSnackBar(snackBar);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          _ShowBankSilkCode(pdfString: this.pdfString),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowBankSilkCode extends StatefulWidget {
  const _ShowBankSilkCode({
    Key key,
    @required this.pdfString,
  }) : super(key: key);

  final String pdfString;

  @override
  __ShowBankSilkCodeState createState() => __ShowBankSilkCodeState();
}

class __ShowBankSilkCodeState extends State<_ShowBankSilkCode> {
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          onPressed: () {
            print(showText);
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
              widget.pdfString,
              // textAlign: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 25),
            ),
          ),
      ],
    );
  }
}
