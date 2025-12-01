import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';

class ProductRatingWidget extends StatelessWidget {
  final double rating;
  final int ratingCount;

  const ProductRatingWidget({
    super.key,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Star icons
        ...List.generate(5, (index) {
          if (index < rating.floor()) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            );
          } else if (index < rating.ceil() && rating % 1 != 0) {
            return const Icon(
              Icons.star_half,
              color: Colors.amber,
              size: 20,
            );
          } else {
            return Icon(
              Icons.star_border,
              color: context.appColors.thirdColor.withAlpha(128),
              size: 20,
            );
          }
        }),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: context.appTextStyles.font16SemiBold,
        ),
        const SizedBox(width: 4),
        Text(
          '($ratingCount ${AppStrings.reviews})',
          style: context.appTextStyles.font14Regular.copyWith(
            color: context.appColors.thirdColor,
          ),
        ),
      ],
    );
  }
}

