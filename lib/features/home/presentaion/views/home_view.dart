import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/routing/routing_constants.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/service_locator.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';
import 'package:flutter_task/features/home/presentaion/widgets/categories_tap_bar/category_filter_tap_bar.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/products_grid_view.dart';
import 'package:flutter_task/features/main_navigation/presentation/cubit/main_navigation_cubit.dart';
import 'package:flutter_task/features/main_navigation/presentation/cubit/main_navigation_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocListener<MainNavigationCubit, MainNavigationState>(
        listener: (context, navigationState) {
          final homeCubit = context.read<HomeCubit>();
          homeCubit.updateWishlistIds(navigationState.wishlistIds);
        },
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (_showLocalAlerts(state)) {
              context.showAlertSnackBar(
                message: AppStrings.youAreInOfflineMode,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.home),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.pushNamed(AppRoutingConstants.search);
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.isFromCache != current.isFromCache,
                  builder: (context, state) {
                    if (_showLocalAlerts(state)) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: const Icon(Icons.wifi_off, size: 20),
                          tooltip: AppStrings.offlineMode,
                          onPressed: () {
                            context.read<HomeCubit>().refreshAll();
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    const CategoryFilterTabBar(),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await context.read<HomeCubit>().refreshAll();
                        },
                        child: const ProductsGridView(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _showLocalAlerts(HomeState state) {
    return state.isFromCache && state.errorMessage != null;
  }
}
