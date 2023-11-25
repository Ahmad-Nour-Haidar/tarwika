import 'package:flutter/material.dart';
import '../../app_icon_icons.dart';
import '../../core/constant/app_color.dart';
import '../../core/functions/functions.dart';

IconButton customArrowBack(void Function() onPressed) {
  return IconButton(
    icon: Icon(
      isEnglish() ? AppIcon.arrow_left : AppIcon.arrow_right,
      size: 32,
    ),
    onPressed: onPressed,
  );
}

class CustomAppBar {
  const CustomAppBar({
    required this.key,
    this.title,
    this.backgroundColor = AppColor.white,
    this.showArrowBack = true,
  });

  final GlobalKey<ScaffoldState>? key;
  final String? title;
  final Color backgroundColor;
  final bool showArrowBack;

  AppBar build(BuildContext context) {
    return AppBar(
      leading: null,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      actions: [
        if (showArrowBack)
          customArrowBack(() {
            Navigator.pop(context);
          }),
        const Spacer(),
        Expanded(
          flex: 4,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              textAlign: TextAlign.center,
              title ?? ' ',
              style: const TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            key!.currentState!.isDrawerOpen
                ? key!.currentState!.closeDrawer()
                : key!.currentState!.openDrawer();
          },
          icon: const Icon(
            AppIcon.menu_1,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}
