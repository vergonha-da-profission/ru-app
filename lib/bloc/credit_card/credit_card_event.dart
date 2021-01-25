part of 'credit_card_bloc.dart';

abstract class CreditCardEvent extends Equatable {
  const CreditCardEvent();

  @override
  List<Object> get props => [];
}

class CreditCardEventAddFoundsCreditCard extends CreditCardEvent {
  final double balance;

  const CreditCardEventAddFoundsCreditCard({
    @required this.balance,
  });

  final name = "Recarga";
  final description = "Cartão de Crédito";

  @override
  List<Object> get props => [balance, name, description];

  @override
  String toString() => 'WalletEventAddFoundsCreditCard { balance: $balance }';
}
