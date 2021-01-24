import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ru/models/user.dart';
import 'package:ru/repository/user_repository.dart';
import 'package:web_socket_channel/io.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  User user;
  String token;
  IOWebSocketChannel userBalanceChannel;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await UserRepository.hasToken();

      if (hasToken) {
        this.token = await UserRepository.getToken();

        user = await UserRepository.getUserData();
        userBalanceChannel = IOWebSocketChannel.connect('ws://10.0.2.2:3030',
            headers: {"authorization": 'Bearer ${this.token}'});
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await UserRepository.persistToken(event.token);
      this.token = await UserRepository.getToken();

      user = await UserRepository.getUserData();
      userBalanceChannel = IOWebSocketChannel.connect('ws://172.21.0.1:3030',
          headers: {"authorization": 'Bearer ${this.token}'});

      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await UserRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
