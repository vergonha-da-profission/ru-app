import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ru/screens/home_screen.dart';
import 'package:ru/screens/login_screen.dart';
import 'package:ru/screens/spash_screen.dart';

import 'bloc/authentication/authentication_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //with PortraitModeMixin {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return MaterialApp(
      title: 'RU',
      // theme: ThemeData(
      //   primaryColor: Color(0xFF6C5B7B),
      //   accentColor: Color(0xFFC06C84),
      //   brightness: Brightness.dark,
      // ),
      // routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc()..add(AppStarted()),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print(state);
            if (state is AuthenticationInitial) {
              return SplashScreen();
            }
            if (state is AuthenticationAuthenticated) {
              return HomeScreen();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginScreen();
            }
            // if (state is AuthenticationLoading) {

            return CircularProgressIndicator();
            // }
          },
        ),
      ),
    );
  }
}
