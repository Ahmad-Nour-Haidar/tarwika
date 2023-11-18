import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_image.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';

class CustomOtherAuth extends StatelessWidget {
  const CustomOtherAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSize.padding20),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  height: 5,
                  color: AppColor.gray2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.size20),
                child: Text(
                  AppStrings.or.tr,
                  style: AppTextTheme.f16w400gray2,
                ),
              ),
              const Expanded(
                child: Divider(
                  height: 5,
                  color: AppColor.gray2,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImage.facebook),
            const SizedBox(width: AppSize.size30),
            Image.asset(AppImage.google),
          ],
        )
      ],
    );
  }
}
