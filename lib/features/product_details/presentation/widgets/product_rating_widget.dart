import 'package:flutter/material.dart';

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
              color: Colors.grey[400],
              size: 20,
            );
          }
        }),
        const SizedBox(width: 8),
        Text(
          '${rating.toStringAsFixed(1)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($ratingCount reviews)',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

