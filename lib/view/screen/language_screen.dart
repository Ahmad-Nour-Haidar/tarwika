import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/custom_button_card.dart';
import 'package:tarwika/view/widget/logo_app.dart';
import '../../controller/local_controller.dart';
import '../widget/back_button_wrapper.dart';
import '../widget/custom_card.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  // static final _sh = AppDependency.getIt<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    final localeController = AppDependency.getIt<LocaleController>();
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
                  textUp: AppStrings.english.tr,
                  textDown: AppStrings.arabic.tr,
                  onTapUp: () {
                    localeController.changeLang('en');
                    pushNamedAndRemoveUntil(AppRoute.typeAuth, context);
                    // _sh.setInt(AppKeysStorage.step, 1);
                  },
                  onTapDown: () {
                    localeController.changeLang('ar');
                    pushNamedAndRemoveUntil(AppRoute.typeAuth, context);
                    // _sh.setInt(AppKeysStorage.step, 1);
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
