import 'package:flutter/material.dart';
import 'package:tarwika/core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/resources/app_text_theme.dart';
import 'custom_button.dart';
import 'custom_card.dart';

class CustomButtonCard extends StatelessWidget {
  const CustomButtonCard({
    super.key,
    required this.textUp,
    required this.textDown,
    required this.onTapUp,
    required this.onTapDown,
  });

  final String textUp;
  final String textDown;

  final void Function() onTapUp;
  final void Function() onTapDown;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: AppSize.padding40,
      widget: Column(
        children: [
          Expanded(
            flex: 2,
            child: CustomButton(
              width: AppSize.width,
              radius: AppSize.radius15,
              text: textUp,
              style: AppTextTheme.f24w600black,
              onTap: onTapUp,
              color: AppColor.primaryColor,
              height: 60,
            ),
          ),
          const Expanded(child: SizedBox(height: AppSize.size25)),
          Expanded(
            flex: 2,
            child: CustomButton(
              width: AppSize.width,
              radius: AppSize.radius15,
              style: AppTextTheme.f24w600black,
              text: textDown,
              onTap: onTapDown,
              color: AppColor.primaryColor,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
