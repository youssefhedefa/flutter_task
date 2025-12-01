import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/generated/assets.dart';
import '../cubit/bottom_nav_cubit.dart';
import '../cubit/bottom_nav_state.dart';
import 'custom_bottom_nav_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      buildWhen: (previous, current) => previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
            selectedItemColor: context.appColors.primaryColor,
            unselectedItemColor: context.appColors.thirdColor,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: [
              CustomBottomNavItem(
                iconPath: Assets.svgsHome,
                label: AppStrings.home,
                isSelected: state.currentIndex == 0,
                context: context,
              ),
              CustomBottomNavItem(
                iconPath: Assets.svgsInactive,
                label: AppStrings.wishlist,
                isSelected: state.currentIndex == 1,
                context: context,
              ),
            ],
          ),
        );
      },
    );
  }
}
