part of 'credit_card_bloc.dart';

abstract class CreditCardState extends Equatable {
  const CreditCardState();

  @override
  List<Object> get props => [];
}

class CreditCardInitial extends CreditCardState {}

class CreditCardSuccess extends CreditCardState {}
