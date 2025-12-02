import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle font34Bold;
  final TextStyle font12RegularThird;
  final TextStyle font14MediumThirdColor;
  final TextStyle font14MediumButtonText;
  final TextStyle font12Regular;
  final TextStyle font16SemiBold;
  final TextStyle font10RegularThird;
  final TextStyle font14Regular;
  final TextStyle font24SemiBold;

  const AppTextStyles({
    required this.font34Bold,
    required this.font12RegularThird,
    required this.font14MediumThirdColor,
    required this.font14MediumButtonText,
    required this.font12Regular,
    required this.font16SemiBold,
    required this.font10RegularThird,
    required this.font14Regular,
    required this.font24SemiBold,
  });

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? font34Bold,
    TextStyle? font12RegularThird,
    TextStyle? font14MediumSecondaryText,
    TextStyle? font14MediumButtonText,
    TextStyle? font12RegularSecondary,
    TextStyle? font16SemiBoldSecondary,
    TextStyle? font10RegularThird,
    TextStyle? font14Regular,
    TextStyle? font24SemiBold,
  }) {
    return AppTextStyles(
      font34Bold: font34Bold ?? this.font34Bold,
      font12RegularThird: font12RegularThird ?? this.font12RegularThird,
      font14MediumThirdColor: font14MediumSecondaryText ?? this.font14MediumThirdColor,
      font14MediumButtonText: font14MediumButtonText ?? this.font14MediumButtonText,
      font12Regular: font12RegularSecondary ?? this.font12Regular,
      font16SemiBold: font16SemiBoldSecondary ?? this.font16SemiBold,
      font10RegularThird: font10RegularThird ?? this.font10RegularThird,
      font14Regular: font14Regular ?? this.font14Regular,
      font24SemiBold: font24SemiBold ?? this.font24SemiBold,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
    covariant ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      font34Bold: TextStyle.lerp(font34Bold, other.font34Bold, t)!,
      font12RegularThird: TextStyle.lerp(font12RegularThird, other.font12RegularThird, t)!,
      font14MediumThirdColor: TextStyle.lerp(font14MediumThirdColor, other.font14MediumThirdColor, t)!,
      font14MediumButtonText: TextStyle.lerp(font14MediumButtonText, other.font14MediumButtonText, t)!,
      font12Regular: TextStyle.lerp(font12Regular, other.font12Regular, t)!,
      font16SemiBold: TextStyle.lerp(font16SemiBold, other.font16SemiBold, t)!,
      font10RegularThird: TextStyle.lerp(font10RegularThird, other.font10RegularThird, t)!,
      font14Regular: TextStyle.lerp(font14Regular, other.font14Regular, t)!,
      font24SemiBold: TextStyle.lerp(font24SemiBold, other.font24SemiBold, t)!,
    );
  }
}

