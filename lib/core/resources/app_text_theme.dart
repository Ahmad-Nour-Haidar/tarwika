import 'package:flutter/material.dart';
import '../constant/app_color.dart';

abstract class AppTextTheme {
  static get f18w500black => const TextStyle(
        fontSize: 18,
        color: AppColor.black,
        fontWeight: FontWeight.w500,
      );

  static get hintStyle => const TextStyle(
        fontSize: 16,
        color: AppColor.white,
        fontWeight: FontWeight.w500,
      );

  static get f20w600black => const TextStyle(
        fontSize: 20,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static get f24w600black => const TextStyle(
        fontSize: 24,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static get f24w600white => const TextStyle(
        fontSize: 24,
        color: AppColor.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      );

  static get f28w600black => const TextStyle(
        fontSize: 28,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static get f28w700black => const TextStyle(
        fontSize: 28,
        color: AppColor.black,
        fontWeight: FontWeight.w700,
      );

  static get f16w400gray2 => const TextStyle(
        fontSize: 16,
        color: AppColor.gray2,
        fontWeight: FontWeight.w400,
      );

  static get f14w600buttonColor => const TextStyle(
        fontSize: 14.0,
        color: AppColor.buttonColor,
        fontWeight: FontWeight.w600,
      );

  static get f28w600buttonColor => const TextStyle(
        fontSize: 28.0,
        color: AppColor.buttonColor,
        fontWeight: FontWeight.w600,
      );

  static get f32w600black => const TextStyle(
        fontSize: 32.0,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );
}
