import 'package:flutter_task/core/constants/app_strings.dart';

class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  static bool isEmailValid(String email) {
    return _emailRegex.hasMatch(email);
  }

  static String? validateEmail(String? value, {bool isValid = false}) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!isValid) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    return null;
  }
}

