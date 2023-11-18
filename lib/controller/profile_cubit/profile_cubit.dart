import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tarwika/core/class/image_helper.dart';
import 'package:tarwika/core/constant/app_link.dart';
import 'package:tarwika/core/constant/app_local_data.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/data/remote/auth_data.dart';
import 'package:tarwika/print.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/check_errors.dart';
import '../../core/functions/functions.dart';
import '../../view/widget/menu/svg_error_image.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppDependency.getIt<AuthRemoteData>();
  File? file;
  bool enableEdit = false;

  void initial() {
    emailController.text = email;
    nameController.text = name;
    phoneController.text = phone;
  }

  String get image {
    return '${AppLink.userImage}/${AppLocalData.user!.data!.image}';
  }

  String get email {
    return '${AppLocalData.user!.data!.email}';
  }

  String get name {
    return '${AppLocalData.user!.data!.name}';
  }

  String get phone {
    return '${AppLocalData.user!.data!.phone}';
  }

  String get textButton {
    if (enableEdit) return AppStrings.done.tr;
    return AppStrings.edit.tr;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }

  Widget get imageWidget {
    final radius = AppSize.width * .75 / 2;
    final widthHeight = 2 * radius;
    if (file != null) {
      return Image.file(
        file!,
        width: widthHeight,
        height: widthHeight,
      );
    }
    return CachedNetworkImage(
      httpHeaders: const {
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5",
      },
      fit: BoxFit.cover,
      width: widthHeight,
      height: widthHeight,
      imageUrl: image,
      errorWidget: (context, url, error) {
        return const SvgErrorImage(size: 75);
      },
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> pickImage() async {
    final temp = await ImageHelper.pickImage();
    if (temp == null) return;
    final tempCrop = await ImageHelper.cropImage(file: temp);
    if (tempCrop == null) return;
    file = File(tempCrop.path);

    emit(ProfileChangeState());
  }

  void onTap() {
    if (enableEdit) {
      edit();
    } else {
      enableEdit = true;
      emit(ProfileChangeState());
    }
  }

  Future<void> edit() async {
    if (!formKey.currentState!.validate()) return;
    emit(ProfileLoadingState());
    final Map<String, dynamic> data = {};
    if (name != nameController.text) {
      data.addAll({AppRKeys.name: nameController.text});
    }
    if (phone != phoneController.text) {
      data.addAll({AppRKeys.phone: phoneController.text});
    }
    final token = AppLocalData.user!.token!;
    final response = await authRemoteData.edit(
      data: data,
      token: token,
      file: file,
    );

    response.fold((l) {
      emit(ProfileFailureState(l));
    }, (r) async {
      enableEdit = false;
      file = null;
      if (r[AppRKeys.status_code] == 400) {
        var s = checkErrorMessages(r[AppRKeys.message][AppRKeys.errors]);
        s = '${AppStrings.field.tr} $s ${AppStrings.alreadyBeenTaken.tr}';
        emit(ProfileFailureState(FailureState(s)));
      } else {
        await storeUser(r);
        emit(ProfileSuccessState(SuccessState(AppStrings.done.tr)));
      }
    });
  }
}
