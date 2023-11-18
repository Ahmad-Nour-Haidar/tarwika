import 'package:flutter/material.dart';
import 'package:tarwika/core/constant/app_color.dart';

import '../../core/constant/app_size.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.widget,
    required this.padding,
  });

  final Widget widget;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radius45),
      ),
      elevation: AppSize.elevation4,
      child: Container(
        height: AppSize.height * 0.3,
        width: AppSize.width,
        color: AppColor.backgroundCardColor,
        padding: EdgeInsets.all(padding),
        child: widget,
      ),
    );
  }
}
