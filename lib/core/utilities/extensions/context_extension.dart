import 'package:flutter/material.dart';
import 'package:flutter_task/core/theming/colors/app_colors.dart';
import 'package:flutter_task/core/theming/text_styles/app_text_styles.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
}
