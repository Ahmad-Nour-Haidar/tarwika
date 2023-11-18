import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/login_cubit/login_state.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/data/remote/auth_data.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppDependency.getIt<AuthRemoteData>();
  bool showPass = false;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void showPassword() {
    showPass = !showPass;
    emit(LoginChangeShowPasswordState());
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoadingState());
    final data = {
      AppRKeys.email: emailController.text,
      AppRKeys.password: passwordController.text,
    };
    final response = await authRemoteData.login(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(LoginFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status_code] == 400) {
        final s = response[AppRKeys.message][AppRKeys.errors].toString();
        final message = s.contains('Password not correct')
            ? AppStrings.passwordNotCorrect.tr
            : AppStrings.userNotFound.tr;
        emit(LoginFailureState(FailureState(message)));
      } else {
        await storeUser(response);
        if (AppLocalData.user!.data!.emailVerifiedAt == null) {
          emit(LoginNotVerifyState());
        } else {
          emit(LoginSuccessState());
        }
      }
    });
  }
}
