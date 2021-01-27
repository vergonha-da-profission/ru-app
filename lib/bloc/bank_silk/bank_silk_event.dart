part of 'bank_silk_bloc.dart';

abstract class BankSilkEvent extends Equatable {
  const BankSilkEvent();

  @override
  List<Object> get props => [];
}

class BankSilkEventGenerate extends BankSilkEvent {
  const BankSilkEventGenerate(this.value);
  final double value;

  @override
  List<Object> get props => [value];
}
