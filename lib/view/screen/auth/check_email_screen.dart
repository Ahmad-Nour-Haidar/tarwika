import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/app_icon_icons.dart';
import 'package:tarwika/core/class/validation.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/functions.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/custom_button.dart';
import 'package:tarwika/view/widget/custom_text_form_field.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import 'package:tarwika/view/widget/logo_app.dart';
import '../../../controller/check_email_cubit/check_email_cubit.dart';
import '../../../controller/check_email_cubit/check_email_state.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../routes.dart';
import '../../widget/back_button_wrapper.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDependency.getIt<CheckEmailCubit>(),
      child: BlocConsumer<CheckEmailCubit, CheckEmailState>(
        listener: (context, state) {
          if (state is CheckEmailFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is CheckEmailSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.resetPassword, context);
          }
        },
        builder: (context, state) {
          final cubit = CheckEmailCubit.get(context);
          return BackButtonWrapper(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    isEnglish() ? AppIcon.arrow_left : AppIcon.arrow_right,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Form(
                key: cubit.formKey,
                child: ListView(
                  padding: const EdgeInsets.all(AppSize.screenPadding),
                  children: [
                    SizedBox(height: AppSize.height * 0.07),
                    const LogoApp(height: 135, width: 135),
                    const SizedBox(height: AppSize.size50),
                    CustomTextFormField(
                      validator: (value) {
                        return ValidateInput.isEmail(value);
                      },
                      textDirection: TextDirection.ltr,
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColor.backgroundCardColor,
                      colorPrefixIcon: AppColor.iconColor,
                      prefixIcon: AppIcon.email,
                      hintText: AppStrings.email.tr,
                    ),
                    const SizedBox(height: AppSize.size40),
                    if (state is CheckEmailLoadingState)
                      const SpinKitThreeBounce(
                        color: AppColor.buttonColor,
                      ),
                    if (state is! CheckEmailLoadingState)
                      CustomButton(
                        width: AppSize.width,
                        text: AppStrings.check.tr,
                        onTap: () {
                          cubit.check();
                        },
                        style: AppTextTheme.f24w600black,
                        color: AppColor.buttonColor,
                        height: AppSize.size50,
                        radius: AppSize.radius20,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
