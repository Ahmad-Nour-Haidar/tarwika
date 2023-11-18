import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../model/order_details_model.dart';
import '../item_details/row_text_span.dart';

class CustomOrderDetailsWidget extends StatelessWidget {
  const CustomOrderDetailsWidget({
    super.key,
    required this.model,
    required this.index,
  });

  final OrderDetailsModel model;
  final int index;

  bool get hasSize => model.categoryName == AppConstant.pizza;

  String get name {
    if (isEnglish()) return model.name!;
    return model.nameAr!;
  }

  static const _height = AppSize.size15;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
                child: Divider(color: AppColor.primaryColor, height: 2)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '( ${index + 1} )',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            const Expanded(
                child: Divider(color: AppColor.primaryColor, height: 50)),
          ],
        ),
        const SizedBox(height: _height),
        Row(
          children: [
            RowTextSpan(
              s1: '${AppStrings.name.tr} : ',
              s2: name,
            ),
          ],
        ),
        if (hasSize) const SizedBox(height: _height),
        if (hasSize)
          Row(
            children: [
              RowTextSpan(
                s1: '${AppStrings.size.tr} : ',
                s2: model.size!.tr,
              ),
            ],
          ),
        const SizedBox(height: _height),
        Row(
          children: [
            RowTextSpan(
              s1: '${AppStrings.meals.tr} : ',
              s2: model.count!.toString(),
            ),
          ],
        ),
        const SizedBox(height: _height),
        Row(
          children: [
            RowTextSpan(
              s1: '${AppStrings.price.tr} : ',
              s2: '${model.itemPrice} S.P',
            ),
          ],
        ),
        const SizedBox(height: _height),
        Row(
          children: [
            RowTextSpan(
              s1: '${AppStrings.totalPrice.tr} : ',
              s2: '${model.totalPrice} S.P',
            ),
          ],
        ),
      ],
    );
  }
}
