import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_strings.dart';

class BackButtonWrapper extends StatefulWidget {
  final Widget child;

  const BackButtonWrapper({
    super.key,
    required this.child,
  });

  @override
  State<BackButtonWrapper> createState() => _BackButtonWrapperState();
}

class _BackButtonWrapperState extends State<BackButtonWrapper> {
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final difference = now.difference(timeBackPressed).inSeconds;
        final isWarning = difference >= 2;
        timeBackPressed = DateTime.now();
        if (isWarning) {
          Fluttertoast.showToast(
            msg: AppStrings.pressBackAgainToExit.tr,
            fontSize: 18,
            backgroundColor: AppColor.snackbarColor,
          );
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: widget.child,
    );
  }
}
