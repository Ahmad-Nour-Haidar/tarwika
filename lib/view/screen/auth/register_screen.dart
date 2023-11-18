import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/register_cubit/register_state.dart';
import 'package:tarwika/core/class/validation.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/routes.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import 'package:tarwika/view/widget/logo_app.dart';
import '../../../app_icon_icons.dart';
import '../../../controller/register_cubit/register_cubit.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../widget/back_button_wrapper.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_other_auth.dart';
import '../../widget/custom_row_text.dart';
import '../../widget/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDependency.getIt<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is RegisterSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.verifyCodeScreen, context);
          }
        },
        buildWhen: (previous, current) {
          return current is! RegisterChangeShowPasswordState;
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
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
                        AppStrings.letGetStarted.tr,
                        style: AppTextTheme.f28w700black,
                      ),
                      const SizedBox(height: AppSize.size25),
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
                      const SizedBox(height: AppSize.size25),
                      CustomTextFormField(
                        validator: (value) {
                          return ValidateInput.isUsername(value);
                        },
                        textDirection: TextDirection.ltr,
                        controller: cubit.userNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        fillColor: AppColor.backgroundCardColor,
                        colorPrefixIcon: AppColor.iconColor,
                        prefixIcon: AppIcon.person,
                        hintText: AppStrings.userName.tr,
                      ),
                      const SizedBox(height: AppSize.size25),
                      CustomTextFormField(
                        validator: (value) {
                          return ValidateInput.isPhone(value);
                        },
                        textDirection: TextDirection.ltr,
                        controller: cubit.phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        fillColor: AppColor.backgroundCardColor,
                        colorPrefixIcon: AppColor.iconColor,
                        prefixIcon: AppIcon.phone,
                        hintText: AppStrings.numberPhone.tr,
                      ),
                      const SizedBox(height: AppSize.size25),
                      BlocSelector<RegisterCubit, RegisterState,
                          RegisterChangeShowPasswordState>(
                        selector: (state) {
                          return RegisterChangeShowPasswordState();
                        },
                        builder: (context, state) {
                          return CustomTextFormField(
                            validator: (value) {
                              return ValidateInput.isPassword(value);
                            },
                            textDirection: TextDirection.ltr,
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            fillColor: AppColor.backgroundCardColor,
                            colorPrefixIcon: AppColor.iconColor,
                            prefixIcon: AppIcon.lock_outline_,
                            hintText: AppStrings.password.tr,
                            suffixIcon:
                                cubit.showPass ? AppIcon.eye : AppIcon.eye_open,
                            obscureText: !cubit.showPass,
                            onTapSuffix: cubit.showPassword,
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.size40),
                      if (state is RegisterLoadingState)
                        const SpinKitThreeBounce(
                          color: AppColor.buttonColor,
                        ),
                      if (state is! RegisterLoadingState)
                        CustomButton(
                          width: AppSize.width,
                          text: AppStrings.register.tr,
                          onTap: () {
                            cubit.register();
                          },
                          style: AppTextTheme.f24w600black,
                          color: AppColor.buttonColor,
                          height: AppSize.size50,
                          radius: AppSize.radius20,
                        ),
                      CustomRowText(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        prefixText: AppStrings.haveAnAccount.tr,
                        suffixText: AppStrings.loginNow.tr,
                        onTap: () {
                          pushNamedAndRemoveUntil(AppRoute.login, context);
                        },
                      ),
                      const SizedBox(height: 25),
                      const CustomOtherAuth(),
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
