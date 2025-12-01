import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/routing/routing_constants.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_state.dart';
import 'package:flutter_task/features/splash/presentation/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.authenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutingConstants.mainNavigation);
        } else if (state.status == SplashStatus.unauthenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutingConstants.login);
        }
      },
      child: const Scaffold(
        body: SplashViewBody(),
      ),
    );
  }
}

