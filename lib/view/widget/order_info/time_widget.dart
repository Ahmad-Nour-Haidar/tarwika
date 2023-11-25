import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_strings.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_local_data.dart';

import '../../../core/resources/app_text_theme.dart';
import '../custom_popup_menu_button.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({
    super.key,
    required this.onChange,
  });

  final void Function(DateTime value) onChange;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  late int hour, minute;
  late String amPm;

  final hourKey = GlobalKey();
  final minuteKey = GlobalKey();
  final amPmKey = GlobalKey();

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() {
    final dateNow = TimeOfDay.now();
    hour = dateNow.hour > 12 ? dateNow.hour % 12 : dateNow.hour;
    minute = dateNow.minute;
    amPm = dateNow.period == DayPeriod.pm ? 'PM' : 'AM';
    change();
  }

  void change() {
    int currentHour = (amPm == 'PM' && hour != 12) ? hour + 12 : hour;
    final date = DateTime(0, 0, 0, currentHour, minute);
    widget.onChange(date);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.time.tr,
          style: AppTextTheme.f28w600buttonColor,
        ),
        const SizedBox(height: 10),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              Expanded(
                child: CustomPopupMenuButton(
                  actionKey: amPmKey,
                  list: AppLocalData.popupMenuItemsAmPm,
                  onChange: (value) {
                    if (amPm == value) return;
                    amPm = value;
                    change();
                  },
                  color: AppColor.white,
                  borderColor: AppColor.buttonColor,
                  valueShow: amPm,
                ),
              ),
              const Gap(10),
              Expanded(
                child: CustomPopupMenuButton(
                  actionKey: hourKey,
                  list: AppLocalData.popupMenuItemsHours,
                  onChange: (value) {
                    final i = int.parse(value);
                    if (hour == i) return;
                    hour = i;
                    change();
                  },
                  color: AppColor.white,
                  borderColor: AppColor.buttonColor,
                  valueShow: hour.toString(),
                ),
              ),
              const Gap(10),
              Expanded(
                child: CustomPopupMenuButton(
                  actionKey: minuteKey,
                  list: AppLocalData.popupMenuItemsMinute,
                  onChange: (value) {
                    final i = int.parse(value);
                    if (minute == i) return;
                    minute = i;
                    change();
                  },
                  color: AppColor.white,
                  borderColor: AppColor.buttonColor,
                  valueShow: minute.toString(),
                ),
              ),
              const Gap(10),
            ],
          ),
        )
      ],
    );
  }
}
