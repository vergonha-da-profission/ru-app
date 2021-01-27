part of 'bank_silk_bloc.dart';

abstract class BankSilkState extends Equatable {
  const BankSilkState();

  @override
  List<Object> get props => [];
}

class BankSilkInitial extends BankSilkState {}

class BankSilkStateSuccess extends BankSilkState {
  const BankSilkStateSuccess(this.bankSilk);
  final BankSilk bankSilk;

  @override
  List<Object> get props => [bankSilk];
}

class BankSilkStateError extends BankSilkState {}

class BankSilkStateLoading extends BankSilkState {}
