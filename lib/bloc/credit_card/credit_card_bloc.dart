import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ru/repository/transaction_repository.dart';

part 'credit_card_event.dart';
part 'credit_card_state.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  CreditCardBloc() : super(CreditCardInitial());

  @override
  Stream<CreditCardState> mapEventToState(
    CreditCardEvent event,
  ) async* {
    if (event is CreditCardEventAddFoundsCreditCard) {
      await TransactionRepository.addFouds(
        description: event.description,
        name: event.name,
        value: event.balance,
      );

      yield CreditCardSuccess();
    }
  }
}
