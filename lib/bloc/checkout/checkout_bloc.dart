import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naurapedia/data/models/responses/list_product_response_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutLoaded(items: [])) {
    on<AddtoCartEvent>((event, emit) {
      final currentState = state as CheckoutLoaded;

      emit(CheckoutLoading());
      emit(CheckoutLoaded(items: [...currentState.items, event.product]));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final currentState = state as CheckoutLoaded;
      currentState.items.remove(event.product);
      emit(CheckoutLoading());
      emit(currentState);
    });
  }
}
