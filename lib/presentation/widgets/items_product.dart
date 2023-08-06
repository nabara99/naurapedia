import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/checkout/checkout_bloc.dart';
import 'package:naurapedia/bloc/get_products/get_products_bloc.dart';

import '../../data/models/responses/list_product_response_model.dart';

import 'package:intl/intl.dart';

class ItemsProduct extends StatefulWidget {
  const ItemsProduct({super.key});

  @override
  State<ItemsProduct> createState() => _ItemsProductState();
}

class _ItemsProductState extends State<ItemsProduct> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsError) {
          return const Center(
            child: Text('data error'),
          );
        }
        if (state is GetProductsLoaded) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text('Data empty'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final Product product = state.data.data![index];
              return Container(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 4,
                ),
                margin: const EdgeInsets.symmetric(
                  // vertical: 2,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'itemPage');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.network(
                          product.attributes!.image!,
                          height: 80,
                          width: 100,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      alignment: Alignment.center,
                      child: Text(
                        product.attributes!.name!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Rp. ${formatAngka(product.attributes!.price!)}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.blueGrey,
                          ),
                          const Text(
                            'cart',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<CheckoutBloc>()
                                  .add(RemoveFromCartEvent(product: product));
                            },
                            child: const Icon(
                              Icons.remove_circle_outline,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              if (state is CheckoutLoaded) {
                                final countItem = state.items
                                    .where(
                                        (element) => element.id == product.id)
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
                              context
                                  .read<CheckoutBloc>()
                                  .add(AddtoCartEvent(product: product));
                            },
                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: state.data.data!.length,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  String formatAngka(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
