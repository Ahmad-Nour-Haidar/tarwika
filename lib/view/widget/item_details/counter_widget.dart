import 'package:flutter/material.dart';
import '../../../app_icon_icons.dart';
import '../../../core/constant/app_color.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.onTapMinus,
    required this.onTapPlus,
    required this.text,
  });

  final void Function() onTapMinus;
  final void Function() onTapPlus;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTapMinus,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(AppIcon.minus)),
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onTapPlus,
            borderRadius: BorderRadius.circular(20),
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(AppIcon.plus)),
          ),
        ],
      ),
    );
  }
}
