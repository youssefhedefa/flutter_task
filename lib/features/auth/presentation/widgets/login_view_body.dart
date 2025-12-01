import 'package:flutter/material.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_email_field.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_password_field.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_title.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.verticalSpace,
              const LoginTitle(),
              60.verticalSpace,
              LoginEmailField(
                controller: _emailController,
              ),
              20.verticalSpace,
              LoginPasswordField(
                controller: _passwordController,
              ),
              40.verticalSpace,
              LoginButton(
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
