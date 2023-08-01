import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/get_products/get_products_bloc.dart';

import '../../data/models/responses/list_product_response_model.dart';

import 'package:intl/intl.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({super.key});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
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
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  vertical: 5,
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
                        // Container(
                        //   padding: const EdgeInsets.all(5),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFF4C53A5),
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: const Text(
                        //     'New',
                        //     style: TextStyle(
                        //       fontSize: 10,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
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
                          height: 85,
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
                          color: Color(0xFF4C53A5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Rp. ${formatAngka(product.attributes!.price!)}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4C53A5),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.shopping_cart_checkout,
                            color: Color(0xFF4C53A5),
                          ),
                          Text(
                            'Add to cart',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                          InkWell(
                            // onTap: () {},
                            child: const Icon(
                              Icons.remove_circle_outline,
                              size: 18,
                              color: Color(0xffEE4D2D),
                            ),
                          ),
                          const Text('0'),
                          InkWell(
                            // onTap: () {},
                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 18,
                              color: Color(0xffEE4D2D),
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
