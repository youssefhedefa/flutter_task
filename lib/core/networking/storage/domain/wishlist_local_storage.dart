import 'base_local_storage.dart';

abstract class WishlistLocalStorage extends CrudLocalStorage<Map<String, dynamic>> {
  Future<void> addToWishlist(Map<String, dynamic> product);

  Future<void> removeFromWishlist(int productId);

  Future<List<Map<String, dynamic>>> getWishlistProducts();

  Future<List<int>> getWishlistIds();

  Future<bool> isInWishlist(int productId);

  Future<bool> toggleWishlist(Map<String, dynamic> product);

  Future<int> getWishlistCount();
}

