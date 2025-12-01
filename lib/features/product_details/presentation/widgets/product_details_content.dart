import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        // App Bar with wishlist button
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
                  color: isInWishlist ? Colors.red : Colors.white,
                  size: 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.3),
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  productDetails.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Rating
                ProductRatingWidget(
                  rating: productDetails.rating,
                  ratingCount: productDetails.ratingCount,
                ),
                const SizedBox(height: 16),

                // Price
                Text(
                  '\$${productDetails.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 24),

                // Description Section
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  productDetails.description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 32),

                // Add to Cart Button (optional - can be implemented later)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement add to cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add to cart feature coming soon!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

