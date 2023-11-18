import 'package:flutter/material.dart';
import 'package:tarwika/app_icon_icons.dart';
import 'package:tarwika/core/class/parent_state.dart';
import 'package:tarwika/view/widget/snack_bar.dart';

void handleState({
  required BuildContext context,
  required ParentState state,
}) {
  switch (state.runtimeType) {
    case OfflineState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.error,
          message: state.message,
          iconData: AppIcon.no_wifi,
        ).show();
        return;
      }
    case ServerFailureState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.error,
          message: state.message,
        ).show();
        return;
      }
    case FailureState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.warning,
          message: state.message,
        ).show();
        return;
      }
    case SuccessState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.success,
          message: state.message,
        ).show();
        return;
      }
  }
}
