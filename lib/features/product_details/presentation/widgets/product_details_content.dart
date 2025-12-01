import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';
import 'package:flutter_task/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter_task/features/product_details/presentation/widgets/product_image_carousel.dart';
import 'package:flutter_task/features/product_details/presentation/widgets/product_rating_widget.dart';

class ProductDetailsContent extends StatelessWidget {
  final ProductDetailsEntity productDetails;
  final bool isInWishlist;
  final int currentImageIndex;

  const ProductDetailsContent({
    super.key,
    required this.productDetails,
    required this.isInWishlist,
    required this.currentImageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: ProductImageCarousel(
              imageUrl: productDetails.image,
              currentIndex: currentImageIndex,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  context.read<ProductDetailsCubit>().toggleWishlist();
                },
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? context.appColors.primaryColor : Colors.white,
                  size: 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withAlpha(76),
                ),
              ),
            ),
          ],
        ),

        // Product Details
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    productDetails.category.toUpperCase(),
                    style: context.appTextStyles.font12Regular.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                12.verticalSpace,

                // Title
                Text(
                  productDetails.title,
                  style: context.appTextStyles.font24SemiBold,
                ),
                12.verticalSpace,

                // Rating
                ProductRatingWidget(
                  rating: productDetails.rating,
                  ratingCount: productDetails.ratingCount,
                ),
                16.verticalSpace,

                // Price
                Text(
                  '\$${productDetails.price.toStringAsFixed(2)}',
                  style: context.appTextStyles.font34Bold.copyWith(
                    color: context.appColors.successColor,
                  ),
                ),
                24.verticalSpace,

                // Description Section
                Text(
                  AppStrings.description,
                  style: context.appTextStyles.font16SemiBold.copyWith(
                    fontSize: 18,
                  ),
                ),
                12.verticalSpace,
                Text(
                  productDetails.description,
                  style: context.appTextStyles.font14Regular.copyWith(
                    height: 1.6,
                    color: context.appColors.thirdColor,
                  ),
                ),
                32.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
