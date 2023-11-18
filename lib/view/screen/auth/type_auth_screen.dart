import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/custom_card.dart';
import 'package:tarwika/view/widget/logo_app.dart';
import '../../widget/back_button_wrapper.dart';
import '../../widget/custom_button_card.dart';

class TypeAuthScreen extends StatelessWidget {
  const TypeAuthScreen({super.key});

  // static final _sh = AppDependency.getIt<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BackButtonWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.screenPadding),
            child: Column(
              children: [
                const Spacer(),
                const CustomCard(
                  widget: LogoApp(
                    width: 200,
                    height: 200,
                  ),
                  padding: AppSize.padding25,
                ),
                const SizedBox(height: 50),
                CustomButtonCard(
                  textUp: AppStrings.login.tr,
                  textDown: AppStrings.createAccount.tr,
                  onTapUp: () {
                    pushNamedAndRemoveUntil(AppRoute.login, context);
                    // _sh.setInt(AppKeysStorage.step, 2);
                  },
                  onTapDown: () {
                    pushNamedAndRemoveUntil(AppRoute.register, context);
                    // _sh.setInt(AppKeysStorage.step, 2);
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
