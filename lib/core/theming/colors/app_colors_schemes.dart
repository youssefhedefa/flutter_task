import 'dart:ui';
import 'package:flutter_task/core/theming/colors/app_colors.dart';

abstract class AppColorSchemes {
  static const AppColors light = AppColors(
    primaryColor: Color(0xFFD13323),
    backgroundColor: Color(0xFFF9F9F9),
    successColor: Color(0xFF34C759),
    secondaryColor: Color(0xFF222222),
    buttonTextColor: Color(0xFFFFFFFF),
    secondaryTextColor: Color(0xFF2D2D2D),
    thirdColor: Color(0xFF9B9B9B),
    listBackgroundColor: Color(0xFFF1F1F1),
  );

  static const AppColors dark = light;
}

