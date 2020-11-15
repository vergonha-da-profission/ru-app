import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ru/screens/home_screen.dart';
import 'package:ru/screens/login_screen.dart';
import 'package:ru/screens/spash_screen.dart';
import 'package:ru/shared/custom_circular_loading.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc()..add(AppStarted()),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return SplashScreen();
            }
            if (state is AuthenticationAuthenticated) {
              return HomeScreen();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginScreen();
            }
            return CustomCircularLoading();
          },
        ),
      ),
    );
  }
}
