import 'package:flutter/material.dart';
import 'package:flutter_task/core/theming/colors/app_colors.dart';
import 'package:flutter_task/core/theming/colors/app_colors_schemes.dart';
import 'package:flutter_task/core/theming/text_styles/app_text_styles.dart';

abstract class AppTextStylesSchemes {
  static const AppColors _lightColors = AppColorSchemes.light;

  static AppTextStyles light = AppTextStyles(
    font34Bold: const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
    ),

    font12RegularThird: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _lightColors.thirdColor,
    ),

    font14MediumThirdColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _lightColors.thirdColor,
    ),

    font14MediumButtonText: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _lightColors.buttonTextColor,
    ),

    font12Regular: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),

    font16SemiBold: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),

    font10RegularThird: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: _lightColors.thirdColor,
    ),

    font14Regular: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    font24SemiBold: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  );

  static AppTextStyles dark = light;
}
