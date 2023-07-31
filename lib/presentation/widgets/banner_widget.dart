import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:naurapedia/common/global_variables.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.bannerImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.asset(
              i,
              fit: BoxFit.contain,
              height: 120,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 120,
        autoPlay: true,
      ),
    );
  }
}
