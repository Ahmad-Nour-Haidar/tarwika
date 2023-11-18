import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_svg.dart';
import '../svg_image.dart';

class SvgErrorImage extends StatelessWidget {
  const SvgErrorImage({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgImage(
      path: AppSvg.noImage,
      color: AppColor.primaryColor,
      size: size,
    );
  }
}
