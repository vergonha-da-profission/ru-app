import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ru/repository/transaction_repository.dart';

part 'bank_silk_event.dart';
part 'bank_silk_state.dart';

class BankSilkBloc extends Bloc<BankSilkEvent, BankSilkState> {
  BankSilkBloc() : super(BankSilkInitial());
  BankSilk bankSilk;

  @override
  Stream<BankSilkState> mapEventToState(
    BankSilkEvent event,
  ) async* {
    if (event is BankSilkEventGenerate) {
      yield BankSilkStateLoading();
      final bankSilk = await TransactionRepository.bankSilk(value: event.value);

      this.bankSilk = bankSilk;

      if (bankSilk != null) {
        yield BankSilkStateSuccess(bankSilk);
      } else {
        yield BankSilkStateError();
      }
    }
  }
}
