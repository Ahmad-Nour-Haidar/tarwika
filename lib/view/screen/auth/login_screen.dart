import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/login_cubit/login_state.dart';
import 'package:tarwika/core/class/validation.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/custom_button.dart';
import 'package:tarwika/view/widget/custom_row_text.dart';
import 'package:tarwika/view/widget/custom_text_form_field.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import 'package:tarwika/view/widget/logo_app.dart';
import '../../../app_icon_icons.dart';
import '../../../controller/login_cubit/login_cubit.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/functions/navigator.dart';
import '../../../routes.dart';
import '../../widget/back_button_wrapper.dart';
import '../../widget/custom_other_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    return BlocProvider(
      create: (_) => AppDependency.getIt<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is LoginNotVerifyState) {
            pushNamedAndRemoveUntil(AppRoute.verifyCodeScreen, context);
          }
          if (state is LoginSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        buildWhen: (previous, current) {
          return current is! LoginChangeShowPasswordState;
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
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
                        AppStrings.welcomeBack.tr,
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
                      BlocSelector<LoginCubit, LoginState,
                          LoginChangeShowPasswordState>(
                        selector: (state) {
                          return LoginChangeShowPasswordState();
                          // return selected state based on the provided state.
                        },
                        builder: (context, state) {
                          // return widget here based on the selected state.
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
                      CustomRowText(
                        mainAxisAlignment: MainAxisAlignment.end,
                        prefixText: ' ',
                        suffixText: AppStrings.forgetPassword.tr,
                        onTap: () {
                          pushNamed(AppRoute.checkEmail, context);
                        },
                      ),
                      const SizedBox(height: AppSize.size10),
                      if (state is LoginLoadingState)
                        const SpinKitThreeBounce(
                          color: AppColor.buttonColor,
                        ),
                      if (state is! LoginLoadingState)
                        CustomButton(
                          width: AppSize.width,
                          text: AppStrings.login.tr,
                          onTap: () {
                            cubit.login();
                          },
                          style: AppTextTheme.f24w600black,
                          color: AppColor.buttonColor,
                          height: AppSize.size50,
                          radius: AppSize.radius20,
                        ),
                      CustomRowText(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        prefixText: AppStrings.doNotHaveAnAccount.tr,
                        suffixText: AppStrings.createAccount.tr,
                        onTap: () {
                          pushNamedAndRemoveUntil(AppRoute.register, context);
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
