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
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    HomeSection(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: EdgeInsets.only(top: 20),
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
