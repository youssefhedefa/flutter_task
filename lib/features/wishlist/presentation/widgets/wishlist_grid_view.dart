import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/product_grid_view_builder.dart';
import 'package:flutter_task/features/main_navigation/presentation/cubit/main_navigation_cubit.dart';
import 'package:flutter_task/features/main_navigation/presentation/cubit/main_navigation_state.dart';
import 'package:flutter_task/features/wishlist/presentation/widgets/empty_wishlist_widget.dart';
import 'package:flutter_task/features/wishlist/presentation/widgets/wishlist_error_widget.dart';

class WishlistGridView extends StatefulWidget {
  const WishlistGridView({super.key});

  @override
  State<WishlistGridView> createState() => _WishlistGridViewState();
}

class _WishlistGridViewState extends State<WishlistGridView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainNavigationCubit>().fetchWishlistProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, state) {
        if (state.wishlistStatus.isLoading && state.wishlistProducts.isEmpty) {
          return _buildSkeletonGrid();
        }

        if (state.wishlistStatus.isFailure && state.wishlistProducts.isEmpty) {
          return WishlistErrorWidget(
            errorMessage: state.wishlistErrorMessage,
            onRetry: () =>
                context.read<MainNavigationCubit>().fetchWishlistProducts(),
          );
        }

        if (state.wishlistProducts.isEmpty) {
          return const EmptyWishlistWidget();
        }

        return ProductGridViewBuilder(products: state.wishlistProducts);
      },
    );
  }

  Widget _buildSkeletonGrid() {
    final dummyProducts = List.generate(
      6,
      (index) => const ProductEntity(
        id: 0,
        title: 'Loading Product Title Here',
        price: 99.99,
        category: 'Loading Category',
        image: '',
        rating: 4.5,
        ratingCount: 100,
      ),
    );

    return ProductGridViewBuilder(products: dummyProducts, isLoading: true);
  }

}
