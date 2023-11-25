import 'package:flutter/material.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FittedBox(
        child: Text(
          text,
          style: AppTextTheme.f14w600buttonColor,
        ),
      ),
    );
  }
}
