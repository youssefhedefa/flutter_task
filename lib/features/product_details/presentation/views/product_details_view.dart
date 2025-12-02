import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
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
        body: SafeArea(
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const ProductDetailsLoading();
              } else if (state.status == RequestStatusEnum.success) {
                if (state.productDetails != null) {
                  return ProductDetailsContent(
                    productDetails: state.productDetails!,
                    isInWishlist: state.isInWishlist,
                    currentImageIndex: state.currentImageIndex,
                  );
                }
                return const ProductDetailsError(
                  message: AppStrings.productNotFound,
                );
              } else if (state.status == RequestStatusEnum.failure) {
                return ProductDetailsError(
                  message: state.errorMessage ?? AppStrings.failedToLoadProduct,
                );
              }
              return const ProductDetailsLoading();
            },
          ),
        ),
      ),
    );
  }
}

