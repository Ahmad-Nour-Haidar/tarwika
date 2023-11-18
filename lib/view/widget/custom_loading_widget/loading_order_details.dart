import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import 'custom_shimmer.dart';

class LoadingOrderDetails extends StatelessWidget {
  const LoadingOrderDetails({super.key});

  double get randomWidth {
    double x = Random().nextInt(30) +
        Random().nextInt(30) +
        Random().nextInt(30) * 1.0;
    x = x < 35 ? 35 : x;
    x = x > 80 ? 80 : x;
    x = AppSize.width * x / 100;
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(4, (index) {
        return CustomShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(5, (index) {
              return Container(
                margin: const EdgeInsets.all(10),
                color: AppColor.white,
                child: SizedBox(
                  width: randomWidth,
                  height: 20,
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
