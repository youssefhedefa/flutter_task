import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/core/utilities/extensions/widget_extension.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/empty_products_widget.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/product_item_widget.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/products_error_widget.dart';

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
    _scrollController.removeListener(_onScroll);
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
        if ((state.productsStatus.isLoading || state.productsStatus.isInitial) &&
            state.products.isEmpty) {
          return _buildSkeletonGrid();
        }

        if (state.productsStatus.isFailure && state.products.isEmpty) {
          return ProductsErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () => context.read<HomeCubit>().fetchProducts(),
          );
        }

        if (state.products.isEmpty) {
          return const EmptyProductsWidget();
        }

        return _buildGridView(
          products: state.products,
          isLoadingMore: state.isLoadingMore,
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
        category: 'Loading Category',
        image: '',
        rating: 4.5,
        ratingCount: 100,
      ),
    );

    return _buildGridView(
      isLoading: true,
      products: dummyProducts,
    );
  }

  Widget _buildGridView({
    bool isLoading = false,
    bool isLoadingMore = false,
    required List<ProductEntity> products,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: isLoadingMore ? products.length + 2 : products.length,
        itemBuilder: (context, index) {
          if (index >= products.length) {
            return ProductItemWidget(
              product: products[0],
            ).loading(isLoading: true);
          }
          return ProductItemWidget(
            product: products[index],
          ).loading(
            isLoading: isLoading,
          );
        },
      ),
    );
  }
}
