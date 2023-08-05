part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class AddtoCartEvent extends CheckoutEvent {
  final Product product;
  AddtoCartEvent({
    required this.product,
  });
}

class RemoveFromCartEvent extends CheckoutEvent {
  final Product product;
  RemoveFromCartEvent({
    required this.product,
  });
}
