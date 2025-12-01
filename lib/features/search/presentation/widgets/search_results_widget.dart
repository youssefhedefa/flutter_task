import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/widgets/products/product_grid_view_builder.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<ProductEntity> products;

  const SearchResultsWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${products.length} ${AppStrings.productsFound}',
            style: context.appTextStyles.font14Regular.copyWith(
              color: context.appColors.thirdColor,
            ),
          ),
        ),
        Expanded(
          child: ProductGridViewBuilder(
            products: products,
          ),
        ),
      ],
    );
  }
}

