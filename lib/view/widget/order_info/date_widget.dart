import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/resources/app_text_theme.dart';
import '../custom_popup_menu_button.dart';
import 'days_widget.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({
    super.key,
    required this.onChange,
  });

  final void Function(DateTime time) onChange;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late GlobalKey _actionKey;
  late DateTime _dateTime;
  late String _chooseMonth;
  late int _chooseDay, _indexMonth;

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() {
    _actionKey = GlobalKey();
    _dateTime = DateTime.now();
    _indexMonth = _dateTime.month;
    _chooseMonth = AppLocalData.monthNames.elementAt(_indexMonth - 1);
    _chooseDay = _dateTime.day;
    widget.onChange(_dateTime);
  }

  void change() {
    final dateNow = DateTime.now();
    _indexMonth = AppLocalData.monthNames.indexOf(_chooseMonth) + 1;
    _dateTime = DateTime(dateNow.year, _indexMonth, _chooseDay);
    widget.onChange(_dateTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppStrings.date.tr,
                style: AppTextTheme.f28w600buttonColor,
              ),
            ),
            Expanded(
              child: CustomPopupMenuButton(
                actionKey: _actionKey,
                list: AppLocalData.popupMenuItemsMonths,
                onChange: (value) {
                  _chooseMonth = value;
                  change();
                },
                color: AppColor.buttonColor,
                borderColor: AppColor.buttonColor,
                valueShow: _chooseMonth,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 20),
        DaysWidget(
          onChange: (value) {
            _chooseDay = value;
            change();
          },
          currentMonthIndex: _indexMonth,
        ),
      ],
    );
  }
}
