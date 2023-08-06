import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/checkout/checkout_bloc.dart';

import 'package:intl/intl.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoaded) {
          final uniqueItem = state.items.toSet().length;
          final dataSet = state.items.toSet();
          return Expanded(
            child: ListView.builder(
              itemCount: uniqueItem,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      elevation: 3,
                      child: Row(
                        children: [
                          Image.network(
                            dataSet.elementAt(index).attributes!.image!,
                            fit: BoxFit.fitWidth,
                            height: 100,
                            width: 90,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 260,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  '${dataSet.elementAt(index).attributes!.name}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                width: 260,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  'Rp. ${formatAngka(dataSet.elementAt(index).attributes!.price!)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 120)),
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<CheckoutBloc>().add(
                                          RemoveFromCartEvent(
                                              product:
                                                  dataSet.elementAt(index)));
                                    },
                                    child: const Icon(
                                      Icons.remove_circle_outline,
                                      size: 18,
                                    ),
                                  ),
                                  BlocBuilder<CheckoutBloc, CheckoutState>(
                                    builder: (context, state) {
                                      if (state is CheckoutLoaded) {
                                        final countItem = state.items
                                            .where((element) =>
                                                element.id ==
                                                dataSet.elementAt(index).id)
                                            .length;
                                        return Text('$countItem');
                                      }
                                      return const Text(
                                        '0',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<CheckoutBloc>().add(
                                          AddtoCartEvent(
                                              product:
                                                  dataSet.elementAt(index)));
                                    },
                                    child: const Icon(
                                      Icons.add_circle_outline,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return const Text('');
      },
    );
  }

  String formatAngka(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
