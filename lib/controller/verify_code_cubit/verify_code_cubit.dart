import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/verify_code_cubit/verify_code_state.dart';
import 'package:tarwika/core/class/parent_state.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/functions/functions.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_strings.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/auth_data.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitialState());

  static VerifyCodeCubit get(BuildContext context) => BlocProvider.of(context);
  late String email, code = '';
  final authRemoteData = AppDependency.getIt<AuthRemoteData>();

  void initial() {
    email = AppLocalData.user!.data!.email!;
  }

  void onSubmit(String verificationCode) {
    code = verificationCode;
  }

  String get message =>
      '${AppStrings.openYourGmailBoxAndEnterTheCodeWasSentTo.tr}\n$email';

  void verifyCode() async {
    if (code.length < 6) {
      emit(VerifyCodeFailureState(
          FailureState(AppStrings.enterTheCompleteVerificationCode.tr)));
      return;
    }
    emit(VerifyCodeLoadingState());
    final data = {
      AppRKeys.email: AppLocalData.user!.data!.email,
      AppRKeys.code: code,
    };
    final response = await authRemoteData.verify(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(VerifyCodeFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status_code] == 400) {
        final message = AppStrings.verifyCodeNotCorrect.tr;
        emit(VerifyCodeFailureState(FailureState(message)));
      } else {
        await storeUser(response);
        emit(VerifyCodeSuccessState());
      }
    });
  }
}
