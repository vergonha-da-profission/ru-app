import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:ru/models/transaction.dart';
import 'package:ru/models/user.dart';
import 'package:ru/repository/user_repository.dart';
import 'package:ru/shared/constants.dart';
import 'package:web_socket_channel/io.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with ChangeNotifier {
  AuthenticationBloc() : super(AuthenticationInitial());

  User user;
  String token;
  IOWebSocketChannel userBalanceChannel;
  IOWebSocketChannel transactionsChannel;

  createTransactionChannel() {
    this.transactionsChannel =
        IOWebSocketChannel.connect(WEB_SOCKET_URL, headers: {
      "authorization": 'Bearer ${this.token}',
      "x-for-event": "transaction",
    });

    transactionsChannel.stream.listen((message) {
      final data = jsonDecode(message);

      final transactionUnparsed = data['transaction'];

      final transaction = Transaction(
        description: transactionUnparsed["description"],
        name: transactionUnparsed["name"],
        price: transactionUnparsed["value"],
        time: DateTime.parse(transactionUnparsed["date_time"]),
        type: transactionUnparsed["type"],
      );

      user.transactions.insert(0, transaction);
    });
  }

  createUserBalanceChannel() {
    userBalanceChannel = IOWebSocketChannel.connect(WEB_SOCKET_URL, headers: {
      "authorization": 'Bearer ${this.token}',
      "x-for-event": "balance",
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await UserRepository.hasToken();

      if (hasToken) {
        this.token = await UserRepository.getToken();

        print(this.token);

        user = await UserRepository.getUserData(this.token);

        createUserBalanceChannel();
        createTransactionChannel();

        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await UserRepository.persistToken(event.token);
      this.token = await UserRepository.getToken();

      user = await UserRepository.getUserData(this.token);

      createUserBalanceChannel();
      createTransactionChannel();

      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await UserRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
