import 'package:flutter/material.dart';
import 'package:tarwika/core/constant/app_size.dart';

import 'custom_text_button.dart';

class CustomRowText extends StatelessWidget {
  const CustomRowText({
    super.key,
    required this.prefixText,
    required this.suffixText,
    required this.onTap,
    required this.mainAxisAlignment,
  });

  final void Function() onTap;
  final MainAxisAlignment mainAxisAlignment;
  final String prefixText;
  final String suffixText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.padding20,
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          // const Spacer(),
          FittedBox(child: Text(prefixText)),
          // const Spacer(),
          CustomTextButton(
            text: suffixText,
            onTap: onTap,
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
