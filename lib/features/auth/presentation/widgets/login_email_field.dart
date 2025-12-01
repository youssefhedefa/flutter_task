import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/validators/app_validators.dart';
import 'package:flutter_task/core/widgets/custom_app_text_field.dart';

class LoginEmailField extends StatefulWidget {
  final TextEditingController controller;

  const LoginEmailField({
    super.key,
    required this.controller,
  });

  @override
  State<LoginEmailField> createState() => _LoginEmailFieldState();
}

class _LoginEmailFieldState extends State<LoginEmailField> {
  bool _isEmailValid = false;

  @override
  void initState() {
    widget.controller.addListener(_validateEmail);
    super.initState();
  }

  void _validateEmail() {
    final email = widget.controller.text;
    setState(() {
      _isEmailValid = AppValidators.isEmailValid(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return CustomAppTextField(
      hintText: AppStrings.email,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      suffixIcon: _isEmailValid
          ? Icon(
              Icons.check,
              color: appColors.successColor,
            )
          : Icon(
              Icons.close,
              color: appColors.primaryColor,
            ),
      validator: (value) =>
          AppValidators.validateEmail(value, isValid: _isEmailValid),
    );
  }
}
