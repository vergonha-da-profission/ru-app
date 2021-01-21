import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';
import 'package:ru/bloc/login/login_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text("Olá, você esta logado"),
            ),
          ),
          FlatButton(
            child: Text("Sair"),
            onPressed: () => LoginBloc(
                    authenticationBloc:
                        BlocProvider.of<AuthenticationBloc>(context))
                .add(
              LoginLogout(),
            ),
          ),
        ],
      ),
    );
  }
}
