import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'popular_category_loading_card.dart';

class PopularCategoryLoading extends StatelessWidget {
  const PopularCategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 11,
          itemBuilder: (context, index) => const PopularCategoryLoadingCard()),
    );
  }
}
