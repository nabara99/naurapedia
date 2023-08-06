import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/checkout/checkout_bloc.dart';
import 'package:naurapedia/bloc/get_products/get_products_bloc.dart';
import 'package:naurapedia/data/datasources/product_remote_datasource.dart';
import 'package:naurapedia/presentation/pages/cart_page.dart';
import 'package:naurapedia/presentation/pages/home_page.dart';
import 'package:naurapedia/presentation/pages/item_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: {
          "/": (context) => const HomePage(),
          "cartPage": (context) => const CartPage(),
          "itemPage": (context) => const ItemPage(),
        },
      ),
    );
  }
}
