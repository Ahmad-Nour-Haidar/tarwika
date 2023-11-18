import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';

class CardDetailsWidget extends StatelessWidget {
  const CardDetailsWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
  });

  final void Function()? onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppSize.radius15),
      elevation: AppSize.elevation4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.radius15),
        child: Container(
          padding: const EdgeInsets.all(AppSize.padding15),
          width: AppSize.width,
          decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(AppSize.radius15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.gray),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
