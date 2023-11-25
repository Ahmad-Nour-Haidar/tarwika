import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tarwika/controller/profile_cubit/profile_cubit.dart';
import 'package:tarwika/controller/profile_cubit/profile_state.dart';
import 'package:tarwika/core/constant/app_size.dart';
import 'package:tarwika/core/functions/functions.dart';
import 'package:tarwika/core/resources/app_text_theme.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/view/widget/custom_drawer.dart';
import 'package:tarwika/view/widget/custom_popup_menu_button.dart';
import 'package:tarwika/view/widget/handle_state.dart';
import '../../app_icon_icons.dart';
import '../../core/class/validation.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_strings.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_form_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final radius = AppSize.width * .75 / 2;
    return BlocProvider(
      create: (context) => AppDependency.getIt<ProfileCubit>()..initial(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          handleState(context: context, state: state.state);
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: CustomAppBar(
              key: scaffoldKey,
            ).build(context),
            drawer: CustomDrawer(
              showCurrentOrderB: false,
              showMyOrdersB: false,
              showProfileB: false,
              showLogoutB: true,
              buildContext: context,
            ),
            body: Form(
              key: cubit.formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSize.screenPadding),
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: cubit.imageWidget,
                      ),
                      if (cubit.enableEdit)
                        Positioned(
                          bottom: 15,
                          left: isEnglish() ? 15 : null,
                          right: isEnglish() ? null : 15,
                          child: ClipOval(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: AppColor.buttonColor, // Button color
                              ),
                              child: InkWell(
                                splashColor: AppColor.transparent,
                                highlightColor: AppColor.transparent,
                                onTap: () {
                                  cubit.pickImage();
                                },
                                child: const SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    size: 20,
                                    Icons.edit,
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: AppSize.size40),
                  CustomTextFormField(
                    enabled: false,
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
                    enabled: cubit.enableEdit,
                    validator: (value) {
                      return ValidateInput.isUsername(value);
                    },
                    textDirection: TextDirection.ltr,
                    controller: cubit.nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColor.backgroundCardColor,
                    colorPrefixIcon: AppColor.iconColor,
                    prefixIcon: AppIcon.person,
                    hintText: AppStrings.userName.tr,
                  ),
                  const SizedBox(height: AppSize.size25),
                  CustomTextFormField(
                    enabled: cubit.enableEdit,
                    validator: (value) {
                      return ValidateInput.isPhone(value);
                    },
                    textDirection: TextDirection.ltr,
                    controller: cubit.phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    fillColor: AppColor.backgroundCardColor,
                    colorPrefixIcon: AppColor.iconColor,
                    prefixIcon: AppIcon.phone,
                    hintText: AppStrings.numberPhone.tr,
                  ),
                  const SizedBox(height: AppSize.size25),
                  const CustomPopupMenuButtonLang(),
                  const SizedBox(height: AppSize.size30),
                  if (state is ProfileLoadingState)
                    const SpinKitThreeBounce(
                      color: AppColor.buttonColor,
                    ),
                  if (state is! ProfileLoadingState)
                    CustomButton(
                      width: AppSize.width,
                      text: cubit.textButton,
                      onTap: cubit.onTap,
                      style: AppTextTheme.f24w600black,
                      color: AppColor.buttonColor,
                      height: AppSize.size50,
                      radius: AppSize.radius20,
                    ),
                  const SizedBox(height: AppSize.size50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// import 'package:path/path.dart';
// import 'package:async/async.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

/// upload(File imageFile) async {
//       // open a bytestream
//       var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//       // get file length
//       var length = await imageFile.length();
//
//       // string to uri
//       var uri = Uri.parse("http://ip:8082/composer/predict");
//
//       // create multipart request
//       var request = new http.MultipartRequest("POST", uri);
//
//       // multipart that takes file
//       var multipartFile = new http.MultipartFile('file', stream, length,
//           filename: basename(imageFile.path));
//
//       // add file to multipart
//       request.files.add(multipartFile);
//
//       // send
//       var response = await request.send();
//       print(response.statusCode);
//
//       // listen for response
//       response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//       });
//     }
