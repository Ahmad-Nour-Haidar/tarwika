import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_keys_request.dart';

String checkErrorMessages(List<dynamic> errors) {
  String result = '';
  for (String error in errors) {
    error = error.toString();
    if (error.toLowerCase().contains(AppRKeys.email)) {
      result.isNotEmpty ? result += ', ' : 1;
      result += AppRKeys.email.tr;
    } else if (error.toLowerCase().contains(AppRKeys.phone)) {
      result.isNotEmpty ? result += ', ' : 1;
      result += AppRKeys.phone.tr;
    } else if (error.toLowerCase().contains(AppRKeys.name)) {
      result.isNotEmpty ? result += ', ' : 1;
      result += AppRKeys.name.tr;
    }
  }
  return result;
}
