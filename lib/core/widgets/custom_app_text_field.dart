import 'package:flutter/material.dart';
import 'package:flutter_task/core/theming/colors/app_colors.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';

class CustomAppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool enabled;

  const CustomAppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final appTextStyles = context.appTextStyles;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      enabled: enabled,
      style: appTextStyles.font14Regular,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: appTextStyles.font14MediumThirdColor,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: colors.buttonTextColor,
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        errorBorder: _buildBorder(color: colors.primaryColor),
        focusedErrorBorder: _buildBorder(color: colors.primaryColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: 1,
      ),
    );
  }
}
