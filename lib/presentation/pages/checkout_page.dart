import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/checkout/checkout_bloc.dart';
import 'package:naurapedia/bloc/order/order_bloc.dart';
import 'package:naurapedia/common/snap_widget.dart';
import 'package:naurapedia/data/models/order_request_model.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(top: 35, bottom: 10, left: 20, right: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black87,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Checkout Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Alamat Pengiriman'),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: addressController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: '',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Item Product'),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  final uniqueItem = state.items.toSet().length;
                  final dataSet = state.items.toSet();
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final count = state.items
                            .where((element) =>
                                element.id == dataSet.elementAt(index).id)
                            .length;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                dataSet.elementAt(index).attributes!.image!),
                          ),
                          title: Text(
                            dataSet.elementAt(index).attributes!.name!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Text('$count'),
                        );
                      },
                      itemCount: uniqueItem,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.green,
                        child: const Text('yes'),
                      );
                    },
                    itemCount: 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                loaded: (model) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SnapWidget(url: model.redirectUrl);
                  }));
                });
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    final total = state.items
                        .fold(0, (sum, item) => sum + item.attributes!.price!);
                    final data = Data(
                      items: state.items
                          .map((e) => Item(
                                id: e.id!,
                                productname: e.attributes!.name!,
                                price: e.attributes!.price!,
                                qyt: 1,
                              ))
                          .toList(),
                      totalPrice: total,
                      deliveryAddress: addressController.text,
                      courierName: 'JNE',
                      shippingCost: 22000,
                      statusOrder: 'waitingPayment',
                    );
                    final requestModel = OrderRequestModel(data: data);
                    context
                        .read<OrderBloc>()
                        .add(OrderEvent.doOrder(requestModel));
                  },
                  child: const Text(
                    'Bayar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
