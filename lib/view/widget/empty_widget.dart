import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';

import '../../core/constant/app_size.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.text,
    required this.lottie,
  });

  final String text;
  final String lottie;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(lottie),
          const SizedBox(height: 30),
          SizedBox(
            width: AppSize.width * .75,
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: AppTextTheme.f28w600black,
            ),
          ),
        ],
      ),
    );
  }
}
