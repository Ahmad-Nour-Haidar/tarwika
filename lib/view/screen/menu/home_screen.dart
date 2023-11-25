import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_image.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/custom_button.dart';

import '../../../core/resources/app_text_theme.dart';
import '../../widget/back_button_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButtonWrapper(
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: AppColor.primaryColor,
                  height: AppSize.height * 0.65,
                ),
                Positioned(
                  bottom: AppSize.height * 0.45,
                  left: 30,
                  right: 30,
                  child: CircleAvatar(
                    radius: (AppSize.width - 60) / 2,
                    backgroundColor: AppColor.white,
                    child: CircleAvatar(
                      radius: (AppSize.width - 80) / 2,
                      backgroundImage: const AssetImage(AppImage.menu),
                    ),
                  ),
                ),
                Positioned(
                  bottom: AppSize.height * 0.20,
                  child: CustomButton(
                    width: AppSize.width * .75,
                    elevation: 0,
                    text: AppStrings.go.tr,
                    onTap: () {
                      pushNamedAndRemoveUntil(AppRoute.menu, context);
                    },
                    style: AppTextTheme.f24w600black,
                    color: AppColor.white,
                    height: AppSize.size40,
                    radius: AppSize.radius20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
