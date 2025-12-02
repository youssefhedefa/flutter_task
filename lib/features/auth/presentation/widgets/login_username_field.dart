import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/widgets/custom_app_text_field.dart';

class LoginUsernameField extends StatelessWidget {
  final TextEditingController controller;

  const LoginUsernameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppTextField(
      hintText: AppStrings.username,
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.usernameRequired;
        }
        return null;
      },
    );
  }
}

