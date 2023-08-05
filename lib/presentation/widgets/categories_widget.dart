import 'package:flutter/material.dart';
import 'package:naurapedia/common/global_variables.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryIcons.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 85,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    GlobalVariables.categoryIcons[index]['image']!,
                    fit: BoxFit.cover,
                    height: 35,
                    width: 40,
                  ),
                ),
              ),
              Text(
                GlobalVariables.categoryIcons[index]['title']!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
