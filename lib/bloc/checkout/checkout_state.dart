part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  List<Product> items;
  CheckoutLoaded({
    required this.items,
  });
}

class CheckoutError extends CheckoutState {}
