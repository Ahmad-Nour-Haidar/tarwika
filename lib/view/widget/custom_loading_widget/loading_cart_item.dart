import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import 'custom_shimmer.dart';

class LoadingCartItem extends StatelessWidget {
  const LoadingCartItem({
    super.key,
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;

  double get width => (AppSize.width - 30);

  double get height => 100;

  int get length {
    return Random().nextInt(3) + 3;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(AppSize.screenPadding),
        children: List.generate(
          length,
          (index) => CustomShimmer(
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSize.padding10),
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(AppSize.radius10)),
            ),
          ),
        ),
      ),
    );
  }
}
