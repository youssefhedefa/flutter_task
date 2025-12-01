import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/service_locator.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';
import 'package:flutter_task/features/home/presentaion/widgets/categories_tap_bar/category_filter_tap_bar.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/products_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.isFromCache && state.errorMessage != null) {
            context.showAlertSnackBar(
              message: AppStrings.youAreInOfflineMode,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
            actions: [
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous.isFromCache != current.isFromCache,
                builder: (context, state) {
                  if (state.isFromCache) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        icon: const Icon(Icons.wifi_off, size: 20),
                        tooltip: 'Offline Mode',
                        onPressed: () {
                          context.read<HomeCubit>().refreshCategories();
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              return Column(
                spacing: 16,
                children: [
                  const CategoryFilterTabBar(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        final cubit = context.read<HomeCubit>();
                        await cubit.fetchCategories(forceRefresh: true);
                        await cubit.fetchProducts();
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
    );
  }
}
