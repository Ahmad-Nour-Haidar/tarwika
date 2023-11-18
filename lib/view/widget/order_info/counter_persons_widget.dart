import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';

import '../../../app_icon_icons.dart';
import '../../../core/constant/app_color.dart';

import '../../../core/constant/app_size.dart';

class CounterPersonsWidget extends StatefulWidget {
  const CounterPersonsWidget({
    super.key,
    required this.onChange,
  });

  final void Function(int value) onChange;

  @override
  State<CounterPersonsWidget> createState() => _CounterPersonsWidgetState();
}

class _CounterPersonsWidgetState extends State<CounterPersonsWidget> {
  int counter = 0;

  void changeCounter(int value) {
    if (counter + value < 0) return;
    setState(() {
      counter += value;
    });
    widget.onChange(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.persons.tr,
          style: AppTextTheme.f28w600buttonColor,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => changeCounter(-1),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(AppSize.radius10),
                    border: Border.all(color: AppColor.buttonColor, width: 3),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(AppIcon.minus),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(AppSize.radius10),
                  border: Border.all(color: AppColor.buttonColor, width: 3),
                ),
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    counter.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () => changeCounter(1),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(AppSize.radius10),
                    border: Border.all(color: AppColor.buttonColor, width: 3),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    AppIcon.plus,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
