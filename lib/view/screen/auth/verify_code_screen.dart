import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/verify_code_cubit/verify_code_cubit.dart';
import 'package:tarwika/controller/verify_code_cubit/verify_code_state.dart';
import 'package:tarwika/core/constant/app_color.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/functions/navigator.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/routes.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../widget/back_button_wrapper.dart';
import '../../widget/custom_button.dart';
import '../../widget/handle_state.dart';
import '../../widget/logo_app.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDependency.getIt<VerifyCodeCubit>()..initial(),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is VerifyCodeSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        builder: (context, state) {
          final cubit = VerifyCodeCubit.get(context);
          return BackButtonWrapper(
            child: Scaffold(
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(AppSize.padding25),
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
                    const SizedBox(height: AppSize.size20),
                    if (state is VerifyCodeLoadingState)
                      const SpinKitThreeBounce(
                        color: AppColor.buttonColor,
                      ),
                    if (state is! VerifyCodeLoadingState)
                      CustomButton(
                        width: AppSize.width,
                        text: AppStrings.verify.tr,
                        onTap: () {
                          cubit.verifyCode();
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
