import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_size.dart';

class DaysWidget extends StatefulWidget {
  const DaysWidget({
    super.key,
    required this.onChange,
    required this.currentMonthIndex,
  });

  final void Function(int value) onChange;
  final int currentMonthIndex;

  @override
  State<DaysWidget> createState() => _DaysWidgetState();
}

class _DaysWidgetState extends State<DaysWidget> {
  late int currentDay;

  late List<int> days;

  double get width =>
      ((AppSize.width - (2 * AppSize.screenPadding)) ~/ 7).toDouble();

  int get currentYear => DateTime.now().year;

  String getText(int day) => day == 0 ? ' ' : day.toString();

  bool isSelected(int value) {
    return currentDay == value;
  }

  int getNumDaysInMonth(int year, int month) {
    if (DateTime(year, month, 31).month == month) return 31;
    if (DateTime(year, month, 30).month == month) return 30;
    if (DateTime(year, month, 29).month == month) return 29;
    // if (DateTime(year, month, 28).month == month)
    return 28;
  }

  String getFirstDayNameInMonth(int year, int month, int day) {
    final date = DateTime(year, month, day);

    /// The day of the week [monday]..[sunday].
    final dayIndex = (date.weekday) % 7;
    final dayName = AppLocalData.dayNames[dayIndex];
    return dayName;
  }

  int previousDays(int year, int month) {
    final nameD = getFirstDayNameInMonth(year, month, 1);
    final index = AppLocalData.dayNames.indexOf(nameD);
    return index;
  }

  List<int> getDays() {
    List<int> list = [];
    final currentY = currentYear;
    final currentM = widget.currentMonthIndex;
    final previous = previousDays(currentY, currentM);
    final numDaysInMonth = getNumDaysInMonth(currentY, currentM);
    list.addAll(List.generate(previous, (index) => 0));
    list.addAll(List.generate(numDaysInMonth, (index) => (index + 1)));
    // printme.green(list);
    return list;
  }

  void changeDay(int value) {
    if (value == 0) return;
    if (currentDay == value) return;
    setState(() {
      currentDay = value;
    });
    widget.onChange(value);
  }

  @override
  void initState() {
    final dateNow = DateTime.now();
    // printme.cyan(widget.currentMonth);
    currentDay = dateNow.day;
    days = getDays();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DaysWidget oldWidget) {
    days = getDays();
    // printme.cyan(widget.currentMonth);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            AppLocalData.dayNamesShort.length,
            (index) => Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppLocalData.dayNamesShort[index].tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColor.buttonColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 0,
          runSpacing: 0,
          children: List.generate(
            days.length,
            (index) => InkWell(
              onTap: () => changeDay(days[index]),
              child: Container(
                padding: const EdgeInsets.all(3),
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: isSelected(days[index])
                        ? AppColor.buttonColor
                        : AppColor.transparent,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    getText(days[index]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
