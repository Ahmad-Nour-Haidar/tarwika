import 'package:flutter/material.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_size.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.style,
    required this.color,
    required this.height,
    required this.radius,
    required this.width,
    this.elevation = AppSize.elevation4,
  });

  final void Function() onTap;
  final String text;
  final TextStyle style;
  final Color color;
  final double height;
  final double width;
  final double radius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        splashColor: AppColor.transparent,
        highlightColor: AppColor.transparent,
        onTap: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Material(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            elevation: elevation,
            child: Container(
              color: color,
              height: height,
              width: width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text.isEmpty ? ' ' : text,
                  style: style,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
