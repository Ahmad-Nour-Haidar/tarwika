import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/functions/functions.dart';
import '../../../generate_material_color.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: isEnglish() ? ShimmerDirection.ltr : ShimmerDirection.rtl,
      baseColor: AppColor.buttonColor,
      highlightColor: generateMaterialColor(color: AppColor.primaryColor),
      child: child,
    );
  }
}
