import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/core/utilities/extensions/widget_extension.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/product_item_widget.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({super.key});

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeCubit>().loadMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.productsStatus == RequestStatusEnum.loading &&
            state.products.isEmpty) {
          return _buildSkeletonGrid();
        }

        if (state.productsStatus == RequestStatusEnum.failure &&
            state.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Failed to load products',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeCubit>().fetchProducts();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.products.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No products found',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }

        final displayedProducts = state.displayedProducts;
        final hasMore = state.hasMoreProducts;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.575,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: displayedProducts.length + (hasMore && state.isLoadingMore ? 2 : 0),
            itemBuilder: (context, index) {
              if (index < displayedProducts.length) {
                return ProductItemWidget(product: displayedProducts[index]);
              } else {
                // Show loading skeleton for next items
                return const ProductItemWidget(
                  product: ProductEntity(
                    id: 0,
                    title: 'Loading Product Title Here',
                    price: 99.99,
                    description: 'Loading description',
                    category: 'Loading Category',
                    image: '',
                    rating: 4.5,
                    ratingCount: 100,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildSkeletonGrid() {
    final dummyProducts = List.generate(
      8,
      (index) => const ProductEntity(
        id: 0,
        title: 'Loading Product Title Here',
        price: 99.99,
        description: 'Loading description',
        category: 'Loading Category',
        image: '',
        rating: 4.5,
        ratingCount: 100,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          return ProductItemWidget(product: dummyProducts[index]).loading();
        },
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    // Create dummy products for loading more skeleton
    final dummyProducts = List.generate(
      2,
      (index) => const ProductEntity(
        id: 0,
        title: 'Loading Product Title Here',
        price: 99.99,
        description: 'Loading description',
        category: 'Loading Category',
        image: '',
        rating: 4.5,
        ratingCount: 100,
      ),
    );

    return SizedBox(
      height: 280,
      child: Row(
        children: [
          Expanded(
            child: ProductItemWidget(product: dummyProducts[0]).loading(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ProductItemWidget(product: dummyProducts[1]).loading(),
          ),
        ],
      ),
    );
  }
}
