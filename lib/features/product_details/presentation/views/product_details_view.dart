import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter_task/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_task/features/product_details/presentation/widgets/product_details_content.dart';
import 'package:flutter_task/features/product_details/presentation/widgets/product_details_loading.dart';
import 'package:flutter_task/features/product_details/presentation/widgets/product_details_error.dart';

class ProductDetailsView extends StatefulWidget {
  final int productId;

  const ProductDetailsView({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          final cubit = context.read<ProductDetailsCubit>();
          context.pop(cubit.hasWishlistChanged ? true : null);
        }
      },
      child: Scaffold(
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatusEnum.loading:
                return const ProductDetailsLoading();
              case RequestStatusEnum.success:
              case RequestStatusEnum.loadedMore:
                if (state.productDetails != null) {
                  return ProductDetailsContent(
                    productDetails: state.productDetails!,
                    isInWishlist: state.isInWishlist,
                    currentImageIndex: state.currentImageIndex,
                  );
                }
                return const ProductDetailsError(
                  message: 'Product details not found',
                );
              case RequestStatusEnum.failure:
                return ProductDetailsError(
                  message: state.errorMessage ?? 'Failed to load product details',
                );
              case RequestStatusEnum.initial:
                return const ProductDetailsLoading();
            }
          },
        ),
      ),
    );
  }
}

