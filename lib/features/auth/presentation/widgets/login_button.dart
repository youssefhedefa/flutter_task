import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/routing/routing_constants.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/widgets/custom_app_button.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_state.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.showSuccessSnackBar(AppStrings.loginSuccess);
          context.pushNamedAndRemoveUntil(AppRoutingConstants.home);
        } else if (state.status.isFailure) {
          context.showErrorSnackBar(state.errorMessage ?? AppStrings.loginError);
        }
      },
      builder: (context, state) {
        return CustomAppButton(
          text: AppStrings.loginButton,
          onPressed: () => _handleLogin(context),
          isLoading: state.status.isLoading,
        );
      },
    );
  }

  void _handleLogin(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );
    }
  }
}
