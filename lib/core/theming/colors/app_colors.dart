import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color backgroundColor;
  final Color successColor;
  final Color secondaryColor;
  final Color buttonTextColor;
  final Color secondaryTextColor;
  final Color thirdColor;
  final Color listBackgroundColor;

  const AppColors({
    required this.primaryColor,
    required this.backgroundColor,
    required this.successColor,
    required this.secondaryColor,
    required this.buttonTextColor,
    required this.secondaryTextColor,
    required this.thirdColor,
    required this.listBackgroundColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? successColor,
    Color? secondaryColor,
    Color? buttonTextColor,
    Color? secondaryTextColor,
    Color? thirdColor,
    Color? listBackgroundColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      successColor: successColor ?? this.successColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      thirdColor: thirdColor ?? this.thirdColor,
      listBackgroundColor: listBackgroundColor ?? this.listBackgroundColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t)!,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      thirdColor: Color.lerp(thirdColor, other.thirdColor, t)!,
      listBackgroundColor: Color.lerp(listBackgroundColor, other.listBackgroundColor, t)!,
    );
  }
}

