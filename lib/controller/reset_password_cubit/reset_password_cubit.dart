import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/class/parent_state.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/data/remote/auth_data.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  late String email, code = '';
  final confirmController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPass = false;
  final authRemoteData = AppDependency.getIt<AuthRemoteData>();

  void initial() async {
    email = AppLocalData.user!.data!.email!;
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }

  void showPassword() {
    showPass = !showPass;
    emit(ResetPasswordChangeShowPasswordState());
  }

  String get message =>
      '${AppStrings.openYourGmailBoxAndEnterTheCodeWasSentTo.tr}\n$email';

  void onSubmit(String verificationCode) {
    code = verificationCode;
  }

  void reset() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (code.length < 6) {
      emit(ResetPasswordFailureState(
          FailureState(AppStrings.enterTheCompleteVerificationCode.tr)));
      return;
    }
    if (passwordController.text != confirmController.text) {
      emit(ResetPasswordFailureState(
          FailureState(AppStrings.passwordsNoMatch.tr)));
      return;
    }
    emit(ResetPasswordLoadingState());
    final data = {
      AppRKeys.email: email,
      AppRKeys.password: passwordController.text,
      AppRKeys.code: code,
    };
    final response = await authRemoteData.resetPassword(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(ResetPasswordFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status_code] == 400) {
        final message = AppStrings.verifyCodeNotCorrect.tr;
        emit(ResetPasswordFailureState(FailureState(message)));
      } else {
        await storeUser(response);
        if (AppLocalData.user!.data!.emailVerifiedAt == null) {
          emit(ResetPasswordNotVerifyState());
        } else {
          emit(ResetPasswordSuccessState());
        }
      }
    });
  }
}
