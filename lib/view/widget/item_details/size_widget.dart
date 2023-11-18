import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import 'row_text_span.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({
    super.key,
    required this.onChange,
    required this.currentSize,
  });

  final Function(String s) onChange;
  final String currentSize;

  static const list = [
    AppConstant.small,
    AppConstant.medium,
    AppConstant.large,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppStrings.size.tr} : ', style: textStyle1()),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            list.length,
            (index) => InkWell(
              onTap: () => onChange(list[index]),
              borderRadius: BorderRadius.circular(AppSize.radius20),
              child: Container(
                alignment: Alignment.center,
                width: 65,
                // height: 30,
                decoration: BoxDecoration(
                  color: currentSize == list[index]
                      ? AppColor.white
                      : AppColor.transparent,
                  borderRadius: BorderRadius.circular(AppSize.radius20),
                  border: Border.all(
                    color: AppColor.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  list[index][0].toUpperCase(),
                  style: textStyle2(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
