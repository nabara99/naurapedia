part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

// ignore: must_be_immutable
class CheckoutLoaded extends CheckoutState {
  List<Product> items;
  CheckoutLoaded({
    required this.items,
  });
}

class CheckoutError extends CheckoutState {}
