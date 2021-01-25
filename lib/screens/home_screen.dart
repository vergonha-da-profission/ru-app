import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';
import 'package:ru/models/user.dart';
import 'package:ru/screens/dashboard/dashboard.dart';
import 'package:ru/screens/profile/profile.dart';
import 'package:ru/screens/transactions/transaction.dart';
import 'package:ru/screens/wallet/wallet.dart';
import 'package:web_socket_channel/io.dart';

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
                child: WebSocketBalance(style: style),
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

class WebSocketBalance extends StatefulWidget {
  WebSocketBalance({
    Key key,
    @required this.style,
  }) : super(key: key);

  final TextStyle style;
  // final IOWebSocketChannel channel;

  @override
  _WebSocketBalanceState createState() => _WebSocketBalanceState();
}

class _WebSocketBalanceState extends State<WebSocketBalance> {
  @override
  void initState() {
    super.initState();
    this._user =
        BlocProvider.of<AuthenticationBloc>(context, listen: false).user;
    this._channel = BlocProvider.of<AuthenticationBloc>(context, listen: false)
        .userBalanceChannel;
  }

  User _user;
  IOWebSocketChannel _channel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: this._channel.stream,
        builder: (context, snapshot) {
          double balance = this._user.balance;
          print(snapshot);

          if (snapshot.hasData) {
            final data = jsonDecode(snapshot.data);

            balance = double.parse("${data["balance"]}");
          }

          return Text(
            "R\$ ${balance.toStringAsFixed(2).replaceFirst('.', ',')}",
            style: widget.style,
          );
        });
  }
}
