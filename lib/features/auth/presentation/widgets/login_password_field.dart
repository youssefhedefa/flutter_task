import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/validators/app_validators.dart';
import 'package:flutter_task/core/widgets/custom_app_text_field.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const LoginPasswordField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppTextField(
      hintText: AppStrings.password,
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: AppValidators.validatePassword,
    );
  }
}

