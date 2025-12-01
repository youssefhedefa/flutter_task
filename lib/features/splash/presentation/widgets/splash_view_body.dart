import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_cubit.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flutter_dash,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 48),
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

