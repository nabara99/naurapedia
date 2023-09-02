import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

import '../../bloc/checkout/checkout_bloc.dart';
import '../../common/global_variables.dart';
import '../../data/datasources/auth_local_datasources.dart';
import '../widgets/cart_app_bar.dart';
import 'package:intl/intl.dart';

import '../widgets/cart_item.dart';
import 'account_page.dart';
import 'auth_page.dart';
import 'checkout_page.dart';
import 'home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int page = 2;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CartAppBar(),
      ),
      body: Column(
        children: [
          const CartItem(),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            if (state is CheckoutLoaded) {
                              final total = state.items.fold(0,
                                  (sum, item) => sum + item.attributes!.price!);
                              return Text(
                                'Rp. ${formatAngka(total)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              );
                            }
                            return const Text(
                              'calculate',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: ElevatedButton(
                        onPressed: () async {
                          final isLogin = await AuthLocalDatasource().isLogin();
                          if (isLogin) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CheckOutPage();
                            }));
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const AuthPage();
                            }));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: (index) {},
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AccountPage();
                      },
                    ),
                  );
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AccountPage();
                    }));
                  },
                  child: const Icon(
                    Icons.person_outline_outlined,
                  ),
                ),
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoaded) {
                    return badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                      ),
                      badgeContent: Text(
                        '${state.items.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      // badgeColor: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CartPage();
                          }));
                        },
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                        ),
                      ),
                    );
                  }
                  return const badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                        elevation: 0, badgeColor: Colors.white),
                    // elevation: 0,
                    badgeContent: Text(
                      '0',
                      style: TextStyle(color: Colors.red),
                    ),
                    // badgeColor: Colors.white,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  );
                },
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  String formatAngka(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
