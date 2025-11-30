import 'package:flutter/material.dart';
import 'package:flutter_task/core/theming/colors/app_colors_schemes.dart';
import 'package:flutter_task/core/theming/text_styles/app_text_styles_schemes.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();

  ThemeData get lightTheme {
    const lightColors = AppColorSchemes.light;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightColors.backgroundColor,
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: lightColors.secondaryColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        lightColors,
        AppTextStylesSchemes.light,
      ],
    );
  }

  ThemeData get darkTheme {
    const darkColors = AppColorSchemes.dark;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkColors.backgroundColor,
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: darkColors.secondaryColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        darkColors,
        AppTextStylesSchemes.dark,
      ],
    );
  }
}
