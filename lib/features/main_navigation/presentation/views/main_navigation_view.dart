import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/service_locator.dart';
import '../cubit/main_navigation_cubit.dart';
import '../cubit/main_navigation_state.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainNavigationCubit>(),
      child: BlocBuilder<MainNavigationCubit, MainNavigationState>(
        buildWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex,
        builder: (context, state) {
          return Scaffold(
            body: state.pages[state.currentIndex],
            bottomNavigationBar: const CustomBottomNavBar(),
          );
        },
      ),
    );
  }
}
