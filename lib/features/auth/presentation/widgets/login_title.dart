import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.login,
      style: context.appTextStyles.font34Bold,
    );
  }
}

