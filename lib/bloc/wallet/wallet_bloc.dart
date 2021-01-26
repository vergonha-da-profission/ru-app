import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ru/repository/transaction_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial());

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is WalletEventAddFoundsCreditCard) {
      await TransactionRepository.addFouds(
        description: event.description,
        name: event.name,
        value: event.balance,
      );
    }
  }
}
