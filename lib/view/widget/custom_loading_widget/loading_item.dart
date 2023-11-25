import 'package:flutter/material.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import 'custom_shimmer.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    super.key,
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;

  double get width => ((AppSize.width - 50) / 2);

  double get height => width + 50;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: List.generate(
              7,
              (index) => CustomShimmer(
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(AppSize.radius10)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
