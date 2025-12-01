import 'package:flutter/material.dart';
import 'package:flutter_task/core/theming/colors/app_colors.dart';
import 'package:flutter_task/core/theming/text_styles/app_text_styles.dart';
import 'package:flutter_task/core/utilities/app_snack_bar.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;


  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?>(
      String routeName, {
        Object? arguments,
      }) {
    return Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  showErrorSnackBar(String message) {
    AppSnackBarShower.showSnackBar(
      context: this,
      message: message,
      state: AppSnackBarStates.error,
    );
  }

  showSuccessSnackBar(String message) {
    AppSnackBarShower.showSnackBar(
      context: this,
      message: message,
      state: AppSnackBarStates.success,
    );
  }
}
