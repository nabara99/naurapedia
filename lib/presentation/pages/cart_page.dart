import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naurapedia/bloc/checkout/checkout_bloc.dart';
import 'package:naurapedia/common/global_variables.dart';
import 'package:naurapedia/presentation/pages/account_page.dart';
import 'package:naurapedia/presentation/pages/home_page.dart';
import 'package:badges/badges.dart' as badges;

import '../widgets/cart_app_bar.dart';
import '../widgets/cart_item_samples.dart';

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
      body: ListView(
        children: [
          const CartAppBar(),
          Container(
            height: 700,
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                const CartItemSamples(),
                Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Add Coupon Code',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const CartBottomNavBar(),
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
                        return AccountPage();
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
                      style: TextStyle(color: Color(0xffEE4D2D)),
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
}
