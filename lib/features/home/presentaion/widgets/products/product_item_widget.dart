import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';
import 'package:flutter_task/core/widgets/custom_cached_network_image.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isInWishlist = state.wishlistIds.contains(product.id);

        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              product.image.isNotEmpty
                  ? AspectRatio(
                      aspectRatio: 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomCachedNetworkImageWidget(
                          imageUrl: product.image,
                        ),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.appTextStyles.font16SemiBold,
                    ),
                    4.verticalSpace,
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.appTextStyles.font12RegularThird,
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.amber,
                        ),
                        4.horizontalSpace,
                        Text(
                          '${product.rating.toStringAsFixed(1)} (${product.ratingCount})',
                          style: context.appTextStyles.font10RegularThird,
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: context.appTextStyles.font14Regular,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: isInWishlist
                                ? context.appColors.primaryColor
                                : context.appColors.thirdColor,
                            size: 22,
                          ),
                          onTap: () {
                            context.read<HomeCubit>().toggleWishlist(product.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
