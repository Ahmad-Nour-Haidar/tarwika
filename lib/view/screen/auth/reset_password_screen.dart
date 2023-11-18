import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/app_icon_icons.dart';
import 'package:tarwika/core/class/validation.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/custom_button.dart';
import 'package:tarwika/view/widget/custom_text_form_field.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import 'package:tarwika/view/widget/logo_app.dart';
import '../../../controller/reset_password_cubit/reset_password_cubit.dart';
import '../../../controller/reset_password_cubit/reset_password_state.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/functions/navigator.dart';
import '../../../routes.dart';
import '../../widget/back_button_wrapper.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDependency.getIt<ResetPasswordCubit>()..initial(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is ResetPasswordNotVerifyState) {
            pushNamedAndRemoveUntil(AppRoute.verifyCodeScreen, context);
          }
          if (state is ResetPasswordSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        buildWhen: (previous, current) {
          return current is! ResetPasswordChangeShowPasswordState;
        },
        builder: (context, state) {
          final cubit = ResetPasswordCubit.get(context);
          return BackButtonWrapper(
            child: Scaffold(
              body: Form(
                key: cubit.formKey,
                child: SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.all(AppSize.screenPadding),
                    children: [
                      SizedBox(height: AppSize.height * 0.07),
                      const LogoApp(height: 135, width: 135),
                      const SizedBox(height: AppSize.size50),
                      Text(
                        cubit.message,
                        style: AppTextTheme.f18w500black,
                      ),
                      const SizedBox(height: AppSize.size40),
                      FittedBox(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: OtpTextField(
                            fieldWidth: 50.0,
                            borderRadius: BorderRadius.circular(AppSize.size15),
                            numberOfFields: 6,
                            borderColor: AppColor.primaryColor,
                            focusedBorderColor: AppColor.buttonColor,
                            enabledBorderColor: AppColor.primaryColor,
                            showFieldAsBox: true,
                            onSubmit: cubit.onSubmit, // end onSubmit
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.size25),
                      BlocSelector<ResetPasswordCubit, ResetPasswordState,
                          ResetPasswordChangeShowPasswordState>(
                        selector: (state) {
                          return ResetPasswordChangeShowPasswordState();
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              CustomTextFormField(
                                validator: (value) {
                                  return ValidateInput.isPassword(value);
                                },
                                textDirection: TextDirection.ltr,
                                controller: cubit.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                fillColor: AppColor.backgroundCardColor,
                                colorPrefixIcon: AppColor.iconColor,
                                prefixIcon: AppIcon.lock_outline_,
                                hintText: AppStrings.password.tr,
                                suffixIcon: cubit.showPass
                                    ? AppIcon.eye
                                    : AppIcon.eye_open,
                                obscureText: !cubit.showPass,
                                onTapSuffix: cubit.showPassword,
                              ),
                              const SizedBox(height: AppSize.size25),
                              CustomTextFormField(
                                validator: (value) {
                                  return ValidateInput.isPassword(value);
                                },
                                textDirection: TextDirection.ltr,
                                controller: cubit.confirmController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                fillColor: AppColor.backgroundCardColor,
                                colorPrefixIcon: AppColor.iconColor,
                                prefixIcon: AppIcon.lock_outline_,
                                hintText: AppStrings.confirm.tr,
                                suffixIcon: cubit.showPass
                                    ? AppIcon.eye
                                    : AppIcon.eye_open,
                                obscureText: !cubit.showPass,
                                onTapSuffix: cubit.showPassword,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.size40),
                      if (state is ResetPasswordLoadingState)
                        const SpinKitThreeBounce(
                          color: AppColor.buttonColor,
                        ),
                      if (state is! ResetPasswordLoadingState)
                        CustomButton(
                          width: AppSize.width,
                          text: AppStrings.reset.tr,
                          onTap: cubit.reset,
                          style: AppTextTheme.f24w600black,
                          color: AppColor.buttonColor,
                          height: AppSize.size50,
                          radius: AppSize.radius20,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
