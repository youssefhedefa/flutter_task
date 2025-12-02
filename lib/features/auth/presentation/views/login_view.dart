import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/service_locator.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_task/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
