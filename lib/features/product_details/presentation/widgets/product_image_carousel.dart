import 'package:flutter/material.dart';
import 'package:flutter_task/core/widgets/custom_cached_network_image.dart';

class ProductImageCarousel extends StatelessWidget {
  final String imageUrl;
  final int currentIndex;

  const ProductImageCarousel({
    super.key,
    required this.imageUrl,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    // For now, we'll display a single image
    // In the future, this can be expanded to support multiple images
    return Container(
      color: Colors.white,
      child: Center(
        child: Hero(
          tag: 'product_image_$imageUrl',
          child: CustomCachedNetworkImageWidget(
            imageUrl: imageUrl,
            height: 400,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}

