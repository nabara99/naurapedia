import 'package:flutter/material.dart';

class GlobalVariables {
  static const baseUrl = 'http://103.150.191.190:1338';
  static const List<Map<String, String>> categoryIcons = [
    {
      'title': 'Books',
      'image': 'assets/icons/books.png',
    },
    {
      'title': 'Computer',
      'image': 'assets/icons/computer.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/icons/fashion.png',
    },
    {
      'title': 'Gadgets',
      'image': 'assets/icons/gadgets.png',
    },
    {
      'title': 'Kitchen',
      'image': 'assets/icons/kitchen_tools.png',
    },
    {
      'title': 'Motorparts',
      'image': 'assets/icons/motorcycle_parts.png',
    },
    {
      'title': 'Shoes',
      'image': 'assets/icons/shoes.png',
    },
    {
      'title': 'Toys',
      'image': 'assets/icons/toys.png',
    },
    {
      'title': 'Vegetables',
      'image': 'assets/icons/vegetables.png',
    },
  ];

  static const List<String> bannerImages = [
    'assets/images/adv.png',
    'assets/images/breakfast.png',
    'assets/images/dinner.png',
    'assets/images/pizza.png',
    'assets/images/boat.png',
  ];

  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.green;
  static const unselectedNavBarColor = Colors.black87;
}
