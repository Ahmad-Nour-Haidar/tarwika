import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/data/remote/auth_data.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';
import 'check_email_state.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  CheckEmailCubit() : super(CheckEmailInitialState());

  static CheckEmailCubit get(BuildContext context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppDependency.getIt<AuthRemoteData>();
  bool showPass = false;

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }

  void check() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(CheckEmailLoadingState());
    var data = {
      AppRKeys.email: emailController.text,
    };
    final response = await authRemoteData.checkEmail(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(CheckEmailFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status_code] == 400) {
        final message = AppStrings.userNotFound.tr;
        emit(CheckEmailFailureState(FailureState(message)));
      } else {
        await storeUser(response);
        emit(CheckEmailSuccessState());
      }
    });
  }
}
