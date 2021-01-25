part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletEventAddFoundsCreditCard extends WalletEvent {
  final double balance;

  const WalletEventAddFoundsCreditCard({
    @required this.balance,
  });

  final name = "Recarga";
  final description = "Cartão de Crédito";

  @override
  List<Object> get props => [balance];

  @override
  String toString() => 'WalletEventAddFoundsCreditCard { balance: $balance }';
}
