import 'base_local_storage.dart';

/// Interface for wishlist local storage operations
/// Domain layer abstraction - no implementation details
abstract class WishlistLocalStorage extends CrudLocalStorage<Map<String, dynamic>> {
  /// Add product to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product);

  /// Remove product from wishlist
  Future<void> removeFromWishlist(int productId);

  /// Get all wishlist products
  Future<List<Map<String, dynamic>>> getWishlistProducts();

  /// Get all wishlist product IDs
  Future<List<int>> getWishlistIds();

  /// Check if product is in wishlist
  Future<bool> isInWishlist(int productId);

  /// Toggle wishlist status (add if not exists, remove if exists)
  Future<bool> toggleWishlist(Map<String, dynamic> product);

  /// Get total wishlist count
  Future<int> getWishlistCount();
}

