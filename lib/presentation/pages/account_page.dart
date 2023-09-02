// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../common/global_variables.dart';
import '../../data/datasources/auth_local_datasources.dart';
import '../../data/models/responses/auth_response_model.dart';
import 'auth_page.dart';
import 'cart_page.dart';
import 'home_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _page = 1;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  User? user;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    user = await AuthLocalDatasource().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              )),
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          Text(user != null
              ? 'Hello ... ${user!.username}'
              : 'Kamu belum login'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300]),
                    child: const Text('List Order')),
                ElevatedButton(
                    onPressed: () async {
                      await AuthLocalDatasource().removeAuthData();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AuthPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]),
                    child: const Text('Logout')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 25,
        onTap: (index) {},
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
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
                    color: _page == 1
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
                child: const Icon(
                  Icons.person_outline_outlined,
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
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoaded) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CartPage();
                            },
                          ),
                        );
                      },
                      child: badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            elevation: 0, badgeColor: Colors.red),
                        // elevation: 0,
                        badgeContent: Text(
                          '${state.items.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        // badgeColor: Colors.white,
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
                      '4',
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
