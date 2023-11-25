import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarwika/core/constant/app_constant.dart';
import 'package:tarwika/core/constant/app_keys_storage.dart';
import 'package:tarwika/core/services/dependency_injection.dart';
import 'package:tarwika/model/cart_model.dart';
import 'package:tarwika/model/category_model.dart';
import 'package:tarwika/model/item_model.dart';
import '../../model/user_model.dart';
import '../constant/app_link.dart';
import '../constant/app_local_data.dart';

bool isEnglish() => AppConstant.currentLocal == AppConstant.localEn;

String getCodeLang() =>
    AppConstant.currentLocal == AppConstant.localEn ? 'en' : 'ar';

String formatDateJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date)
      .format(pattern: 'EEEE, MMMM, d - MM - yyyy');
}

String formatTimeJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date).format(pattern: 'h:mm a');
}

TextDirection getTextDirection(String value) {
  if (value.contains(RegExp(r"[\u0600-\u06FF]"))) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}

TextDirection getTextDirectionOnLang() {
  if (isEnglish()) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

Future<void> storeUser(Map<String, dynamic> response) async {
  final user = User.fromJson(response);
  final sh = AppDependency.getIt<SharedPreferences>();
  final jsonString = jsonEncode(user.toJson());
  await sh.setString(AppKeysStorage.user, jsonString);
  AppLocalData.user = user;
  // printme.green(user.token);
  // sh.setInt(AppKeysStorage.id, user.data!.id!);
  // sh.setString(AppKeysStorage.name, user.data!.name!);
  // sh.setString(AppKeysStorage.email, user.data!.email!);
  // sh.setString(AppKeysStorage.image, user.data!.image!);
  // sh.setString(AppKeysStorage.phone, user.data!.phone!);
  // sh.setString(AppKeysStorage.token, user.token ?? '');
}

void initialUser() {
  final sh = AppDependency.getIt<SharedPreferences>();
  var jsonString = sh.getString(AppKeysStorage.user);
  if (jsonString == null) {
    return;
  }
  Map<String, dynamic> m = jsonDecode(jsonString);
  var user = User.fromJson(m);
  AppLocalData.user = user;
  // printme.green(user.token);
  return;
}

String getItemName(ItemModel itemModel) =>
    isEnglish() ? itemModel.name! : itemModel.nameAr!;

String getItemDescription(ItemModel itemModel) =>
    isEnglish() ? itemModel.description! : itemModel.descriptionAr!;

String getCategoryName(CategoryModel categoryModel) =>
    isEnglish() ? categoryModel.name! : categoryModel.nameAr!;

String getImageCategoryLink(String image) => '${AppLink.categoryImage}/$image';

String getImageItemLink(String image) => '${AppLink.itemImage}/$image';

String getCartName(CartModel cartModel) =>
    isEnglish() ? cartModel.name! : cartModel.nameAr!;
