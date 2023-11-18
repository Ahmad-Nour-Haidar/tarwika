import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/register_cubit/register_state.dart';
import 'package:tarwika/core/class/parent_state.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/check_errors.dart';
import 'package:tarwika/core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/auth_data.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppDependency.getIt<AuthRemoteData>();
  bool showPass = false;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    return super.close();
  }

  void showPassword() {
    showPass = !showPass;
    emit(RegisterChangeShowPasswordState());
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(RegisterLoadingState());
    final data = {
      AppRKeys.email: emailController.text,
      AppRKeys.name: userNameController.text,
      AppRKeys.phone: phoneController.text,
      AppRKeys.password: passwordController.text,
    };
    final response = await authRemoteData.register(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(RegisterFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status_code] == 400) {
        var s = checkErrorMessages(response[AppRKeys.message][AppRKeys.errors]);
        s = '${AppStrings.field.tr} $s ${AppStrings.alreadyBeenTaken.tr}';
        emit(RegisterFailureState(FailureState(s)));
      } else {
        await storeUser(response);
        emit(RegisterSuccessState());
      }
    });
  }
}
