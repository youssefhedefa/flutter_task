import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';
import 'package:flutter_task/core/utilities/extensions/widget_extension.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';
import 'package:flutter_task/features/home/presentaion/widgets/categories_tap_bar/category_filter_tap_bar_item.dart';

class CategoryFilterTabBar extends StatelessWidget {
  const CategoryFilterTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.categoryStatus.isLoading) {
            return _buildList(
              isLoading: true,
              categories: List.generate(
                3,
                (index) => const CategoryEntity(name: 'loading'),
              ),
              selectedCategory: '',
            );
          }

          if (state.categoryStatus.isFailure) {
            return Center(
              child: Text(
                'Failed to load categories',
                style: TextStyle(color: Colors.red[700]),
              ),
            );
          }

          if (state.categories.isEmpty) {
            return const SizedBox.shrink();
          }

          return _buildList(
            isLoading: false,
            categories: state.categories,
            selectedCategory: state.selectedCategory,
          );
        },
      ),
    );
  }

  Widget _buildList({
    bool isLoading = false,
    required List<CategoryEntity> categories,
    required String selectedCategory,
  }) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryFilterTabBarItem(
          label: category.name,
          isSelected: selectedCategory == category.name,
          onTap: () {
            context.read<HomeCubit>().selectCategory(category.name);
          },
        );
      },
      separatorBuilder: (context, index) => 12.horizontalSpace,
    ).loading(isLoading: isLoading);
  }
}
