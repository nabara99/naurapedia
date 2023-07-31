import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:naurapedia/presentation/widgets/banner_widget.dart';
import 'package:naurapedia/presentation/widgets/home_app_bar.dart';
import 'package:naurapedia/presentation/widgets/categories_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/items_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          Container(
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 27,
                        color: Color(0xFF4C53A5),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 5,
                        ),
                        height: 35,
                        width: 300,
                        child: TextFormField(
                          onFieldSubmitted: (_) {},
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  child: const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                const CategoriesWidget(),
                const SizedBox(
                  height: 5,
                ),
                const BannerWidget(),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: const Text(
                    'List Products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: ItemsWidget()),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {},
        height: 45,
        color: const Color(0xFF4C53A5),
        items: const [
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.cart,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.person_3_outlined,
            size: 25,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
