import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../core/functions/navigator.dart';
import '../../../model/order_model.dart';
import '../../../model/screen_arguments.dart';
import '../../../routes.dart';
import '../item_details/row_text_span.dart';

class MyOrderWidget extends StatelessWidget {
  const MyOrderWidget({
    super.key,
    required this.model,
  });

  final OrderModel model;

  String get date {
    final dateTime = DateTime.parse(model.reservationDateTime!);
    return formatDateJiffy(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final id =
        isEnglish() ? '${AppStrings.id.tr} : # ' : '${AppStrings.id.tr} : # ';
    return InkWell(
      onTap: () {
        pushNamed(AppRoute.orderDetails, context,
            arguments: ScreenArguments({
              AppKeys.orderModel: model,
            }));
      },
      child: Material(
        elevation: AppSize.elevation4,
        color: AppColor.cardColor,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppSize.radius10),
        child: Container(
          padding: const EdgeInsets.all(AppSize.padding10),
          child: Column(
            children: [
              Row(
                children: [
                  RowTextSpan(
                    s1: id,
                    s2: '${model.id}',
                  ),
                ],
              ),
              Row(
                children: [
                  RowTextSpan(
                    s1: '${AppStrings.totalPrice.tr} : ',
                    s2: '${model.totalPrice} S.P',
                  ),
                ],
              ),
              Row(
                children: [
                  RowTextSpan(
                    s1: '${AppStrings.date.tr} : ',
                    s2: date,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
