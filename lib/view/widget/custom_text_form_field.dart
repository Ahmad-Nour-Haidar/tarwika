import 'package:flutter/material.dart';
import 'package:tarwika/core/functions/functions.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.textInputAction,
    required this.fillColor,
    required this.colorPrefixIcon,
    required this.prefixIcon,
    required this.hintText,
    this.onFieldSubmitted,
    this.textDirection,
    this.onTapSuffix,
    this.suffixIcon,
    this.obscureText,
    this.size = AppSize.size20,
    this.hintStyle,
    this.borderRadius = AppSize.radius15,
    this.contentPadding = const EdgeInsets.all(15),
    this.height,
    this.onTap,
    this.onTapPrefix,
    this.enabled = true,
  });

  final void Function()? onTapSuffix;
  final void Function()? onTapPrefix;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color fillColor;
  final Color colorPrefixIcon;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final bool? obscureText;
  final double size;
  final double? height;
  final double borderRadius;
  final TextDirection? textDirection;
  final TextStyle? hintStyle;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;

  TextDirection get getDirectionality {
    if (textDirection != null) {
      return textDirection!;
    }
    if (isEnglish()) {
      return TextDirection.ltr;
    }
    return TextDirection.rtl;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getDirectionality,
      child: SizedBox(
        height: height,
        child: TextFormField(
          enabled: enabled,
          onTap: onTap,
          // onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textDirection: getTextDirection(controller.text),
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText ?? false,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            hintTextDirection:
                isEnglish() ? TextDirection.ltr : TextDirection.rtl,
            hintText: hintText,
            fillColor: fillColor,
            filled: true,
            prefixIcon: Icon(
              prefixIcon,
              color: colorPrefixIcon,
              size: size,
            ),
            suffixIcon: suffixIcon != null
                ? InkWell(
                    borderRadius: BorderRadius.circular(borderRadius),
                    onTap: onTapSuffix,
                    child: Icon(
                      suffixIcon,
                      color: AppColor.iconColor,
                      size: size,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
