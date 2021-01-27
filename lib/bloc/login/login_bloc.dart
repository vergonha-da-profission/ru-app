import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';
import 'package:ru/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    this.userRepository,
    @required this.authenticationBloc,
  })  : assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await UserRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        if (token == null) {
          throw Exception('Password or username incorrect.');
        }

        await UserRepository.persistToken(token);

        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: 'Usuário ou senha inválidos');
      }
    }

    if (event is LoginLogout) {
      authenticationBloc.add(LoggedOut());

      yield LoginLoading();
    }
  }
}
