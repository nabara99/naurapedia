import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/get_products/get_products_bloc.dart';
import 'package:naurapedia/data/datasources/product_remote_datasource.dart';
import 'package:naurapedia/presentation/pages/cart_page.dart';
import 'package:naurapedia/presentation/pages/home_page.dart';
import 'package:naurapedia/presentation/pages/item_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductsBloc(ProductRemoteDatasource()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: {
          "/": (context) => const HomePage(),
          "cartPage": (context) => const CartPage(),
          "itemPage": (context) => ItemPage(),
        },
      ),
    );
  }
}
