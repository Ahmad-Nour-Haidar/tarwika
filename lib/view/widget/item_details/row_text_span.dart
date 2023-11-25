import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/functions/functions.dart';

class RowTextSpan extends StatelessWidget {
  const RowTextSpan({
    super.key,
    required this.s1,
    required this.s2,
  });

  final String s1, s2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        alignment: isEnglish() ? Alignment.centerLeft : Alignment.centerRight,
        fit: BoxFit.scaleDown,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: s1, style: textStyle1()),
              TextSpan(text: s2, style: textStyle2()),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle textStyle1() => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.black,
    );

TextStyle textStyle2() => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColor.black,
    );
