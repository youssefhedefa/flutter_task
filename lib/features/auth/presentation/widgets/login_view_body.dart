import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_username_field.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_password_field.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_title.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AbsorbPointer(
        absorbing: context.watch<LoginCubit>().state.status.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.verticalSpace,
                const LoginTitle(),
                60.verticalSpace,
                LoginUsernameField(
                  controller: _usernameController,
                ),
                20.verticalSpace,
                LoginPasswordField(
                  controller: _passwordController,
                ),
                40.verticalSpace,
                LoginButton(
                  formKey: _formKey,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
