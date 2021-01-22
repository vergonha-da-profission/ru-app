import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// This is the private State class that goes with HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Transactions(),
    HomeSection(),
    ProfileSection(),
    Wallet(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: Stack(
          children: [
            _AppBar(onTapped: _onItemTapped),
            Container(
              margin: EdgeInsets.only(top: AppBar().preferredSize.height),
              child: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex < 3 ? _selectedIndex : _selectedIndex - 1,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            decoration: InputDecoration(
              hintText: '0,00',
            ),
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 23,
            ),
          ),
          PaymentArea()
        ],
      ),
    );
  }
}

class PaymentArea extends StatelessWidget {
  const PaymentArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreditCardScreen()),
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

class HomeSection extends StatelessWidget {
  const HomeSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          // The number of tabs / content sections to display.
          length: 3,
          child: Container(), // Complete this code in the next step.
        ),
        Container(
          child: Column(
            children: [
              _ProfilePicture(
                imageUrl: 'http://placekitten.com/200/300',
              ),
              _UserName(
                name: 'Name teste',
              ),
              _QrCode(
                imageUrl:
                    'http://www.pngall.com/wp-content/uploads/2/QR-Code-PNG-Clipart.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        this.name,
        style: GoogleFonts.roboto(
          fontSize: 33,
        ),
      ),
    );
  }
}

class _QrCode extends StatelessWidget {
  const _QrCode({
    @required this.imageUrl,
    Key key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.width * .7,
      child: Image.network(imageUrl),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      width: MediaQuery.of(context).size.width * .35,
      height: MediaQuery.of(context).size.width * .35,
      child: ClipOval(
        child: Image.network(
          this.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key key, this.onTapped}) : super(key: key);

  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    final size = AppBar().preferredSize;

    final style = GoogleFonts.roboto(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );

    return Column(
      children: [
        Container(
          width: size.width,
          color: Theme.of(context).accentColor,
          height: size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  onTapped(3);
                },
                child: Text(
                  'Carteira',
                  style: style,
                ),
              ),
              InkWell(
                child: Text(
                  "R\$ 0,25",
                  style: style,
                ),
                onTap: () {
                  onTapped(1);
                },
              ),
              InkWell(
                child: Text(
                  'Perfil',
                  style: style,
                ),
                onTap: () {
                  onTapped(2);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) => Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              _ProfileImageSection(
                maxHeight: constraints.maxHeight,
              ),
              SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _ProfileSectionItem(
                              icon: Icons.person_outline, name: 'Guilherme'),
                          _ProfileSectionItem(
                              icon: Icons.addchart_rounded, name: '1721101026'),
                          _ProfileSectionItem(
                              icon: Icons.email_outlined,
                              name: 'guilherme.silva97'),
                          _ProfileSectionItem(
                            icon: Icons.assignment_ind_outlined,
                            name: '123.123.123-12',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSectionItem extends StatelessWidget {
  const _ProfileSectionItem({
    Key key,
    @required this.icon,
    @required this.name,
  }) : super(key: key);

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            icon,
            size: 35,
          ),
          SizedBox(width: 10),
          Text(
            name,
            style: GoogleFonts.roboto(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class _ProfileImageSection extends StatelessWidget {
  const _ProfileImageSection({Key key, @required this.maxHeight})
      : super(key: key);

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: this.maxHeight * .3,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: this.maxHeight * .05,
          ),
          height: 200,
          width: 200,
          child: ClipOval(
            child: Image.network(
              'http://placekitten.com/200/300',
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}

class CreditCardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditCardScreenState();
  }
}

class CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      cvvValidationMessage: 'Insira uma data valida',
                      dateValidationMessage: 'Insira um CVV válido',
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
                          print('valid!');
                        } else {
                          print('invalid!');
                        }
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

class BankSilkScreen extends StatelessWidget {
  const BankSilkScreen({
    Key key,
    @required this.pdfString,
  }) : super(key: key);

  final String pdfString;

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
