import 'package:flutter/material.dart';
import 'package:flutter_task/core/utilities/extensions/widget_extension.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/product_item_widget.dart';

class ProductGridViewBuilder extends StatelessWidget {
  final bool isLoading;
  final bool isLoadingMore;
  final List<ProductEntity> products;
  final ScrollController? scrollController;

  const ProductGridViewBuilder({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.scrollController,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        controller: scrollController,
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
