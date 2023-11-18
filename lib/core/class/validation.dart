import 'package:get/get.dart';
import 'package:tarwika/core/constant/app_strings.dart';
import 'package:tarwika/core/functions/functions.dart';

class ValidateInput {
  ValidateInput._();

  static const _regExpEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const _regExpPhone = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  static const _regExpUsername = r'^[a-zA-Z0-9][a-zA-Z0-9_. ]+[a-zA-Z0-9]$';

  static String _getMessageLength(int mn, int mx) =>
      '${AppStrings.lengthMustBeBetween.tr} $mn - $mx';

  static String _getMessageNotValid(String field) =>
      '$field ${AppStrings.notValid.tr}';

  static String? isEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldCantBeEmpty.tr;
    }
    if (!_hasMatch(value, _regExpEmail)) {
      return _getMessageNotValid(AppStrings.email.tr);
    }
    if (!value.endsWith('@gmail.com')) {
      return isEnglish()
          ? '${AppStrings.emailMustBeEndWith.tr}: @gmail.com'
          : '@gmail.com :${AppStrings.emailMustBeEndWith.tr}';
    }
    if (value.length < 13 || value.length > 50) {
      return _getMessageLength(13, 50);
    }
    return null;
  }

  static String? isPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 6 || value.length > 50) {
      return _getMessageLength(6, 50);
    }
    return null;
  }

  static String? isPhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 9 || value.length > 16) {
      return _getMessageLength(9, 16);
    }
    if (!_hasMatch(value, _regExpPhone)) {
      return _getMessageNotValid(AppStrings.phone.tr);
    }
    return null;
  }

  static String? isUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 3 || value.length > 50) {
      return _getMessageLength(3, 50);
    }
    if (!_hasMatch(value, _regExpUsername)) {
      return _getMessageNotValid(AppStrings.userName.tr);
    }
    return null;
  }

  static bool _hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
}

// class ValidateInput {
//   ValidateInput._();
//
//   static const _regExpEmail =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   static const _regExpPhone = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
//   static const _regExpUsername = r'^[a-zA-Z0-9][a-zA-Z0-9_. ]+[a-zA-Z0-9]$';
//
//   static String? isEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'this filed can\'t be empty';
//     }
//     if (value.length < 15 || value.length > 50) {
//       return 'length must be between 15-50 character';
//     }
//     if (!value.endsWith('@gmail.com')) {
//       return 'email must be end with: @gmail.com';
//     }
//     if (!_hasMatch(value, _regExpEmail)) {
//       return 'email not valid';
//     }
//     return null;
//   }
//
//   static String? isPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'this filed can\'t be empty';
//     }
//     if (value.length < 6 || value.length > 50) {
//       return 'length must be between 6-50 character';
//     }
//     return null;
//   }
//
//   static String? isPhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'this filed can\'t be empty';
//     }
//     if (value.length < 9 || value.length > 16) {
//       return 'length must be between 9-16 character';
//     }
//     if (!_hasMatch(value, _regExpPhone)) {
//       return 'phone not valid';
//     }
//     return null;
//   }
//
//   static String? isUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'this filed can\'t be empty';
//     }
//     if (value.length < 5 || value.length > 50) {
//       return 'length must be between 5-50 character';
//     }
//     if (!_hasMatch(value, _regExpUsername)) {
//       return 'username not valid';
//     }
//     return null;
//   }
//
//   static bool _hasMatch(String? value, String pattern) {
//     return (value == null) ? false : RegExp(pattern).hasMatch(value);
//   }
// }
