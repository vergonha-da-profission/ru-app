// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ru/bloc/authentication/authentication_bloc.dart';
// import 'package:ru/bloc/login/login_bloc.dart';

// class HomeScreen extends StatelessWidget  {
//   const HomeScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             child: Center(
//               child: Text("Olá, você esta logado"),
//             ),
//           ),
//           FlatButton(
//             child: Text("Sair"),
//             onPressed: () => LoginBloc(
//                     authenticationBloc:
//                         BlocProvider.of<AuthenticationBloc>(context))
//                 .add(
//               LoginLogout(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// This is the private State class that goes with HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Transactions(),
    HomeSection(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
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
        child: Column(
          children: [
            _AppBar(onTapped: _onItemTapped),
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
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
          SvgPicture.asset(
            'assets/svg/card.svg',
            semanticsLabel: 'Card',
            width: 100,
          ),
          SvgPicture.asset(
            'assets/svg/bank.svg',
            semanticsLabel: 'Card',
            width: 100,
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

    return Container(
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
    );
  }
}

class Transactions extends StatelessWidget {
  const Transactions({Key key}) : super(key: key);

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
                      'Depósito na carteira',
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'R\$ 5,00',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cartão de Crédito',
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
                      '15 minutos',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      'assets/svg/outgoing_payments.svg',
                      width: 80,
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
