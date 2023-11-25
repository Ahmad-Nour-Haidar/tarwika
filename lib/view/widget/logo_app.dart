import 'package:flutter/material.dart';

import '../../core/constant/app_image.dart';
import '../../core/functions/functions.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isEnglish() ? AppImage.logo : AppImage.logoAr,
      width: width,
      height: height,
    );
  }
}
