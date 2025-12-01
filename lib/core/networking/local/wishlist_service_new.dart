import 'package:hive_flutter/hive_flutter.dart';

class WishlistService {
  static const String _wishlistBoxName = 'wishlist_box';

  // Get wishlist box
  static Future<Box<dynamic>> getWishlistBox() async {
    if (!Hive.isBoxOpen(_wishlistBoxName)) {
      return await Hive.openBox(_wishlistBoxName);
    }
    return Hive.box(_wishlistBoxName);
  }

  // Add product to wishlist
  static Future<void> addToWishlist(Map<String, dynamic> product) async {
    final box = await getWishlistBox();
    final productId = product['id'] as int;
    await box.put('product_$productId', product);
  }

  // Remove product from wishlist
  static Future<void> removeFromWishlist(int productId) async {
    final box = await getWishlistBox();
    await box.delete('product_$productId');
  }

  // Get all wishlist products
  static Future<List<Map<String, dynamic>>> getWishlistProducts() async {
    final box = await getWishlistBox();
    final products = <Map<String, dynamic>>[];

    for (var key in box.keys) {
      if (key.toString().startsWith('product_')) {
        final product = box.get(key);
        if (product is Map) {
          products.add(Map<String, dynamic>.from(product));
        }
      }
    }

    return products;
  }

  // Get all wishlist product IDs
  static Future<List<int>> getWishlist() async {
    final products = await getWishlistProducts();
    return products.map((p) => p['id'] as int).toList();
  }

  // Check if product is in wishlist
  static Future<bool> isInWishlist(int productId) async {
    final box = await getWishlistBox();
    return box.containsKey('product_$productId');
  }

  // Toggle wishlist status
  static Future<bool> toggleWishlist(Map<String, dynamic> product) async {
    final productId = product['id'] as int;
    final isInWishlist = await WishlistService.isInWishlist(productId);
    if (isInWishlist) {
      await removeFromWishlist(productId);
      return false;
    } else {
      await addToWishlist(product);
      return true;
    }
  }

  // Clear all wishlist
  static Future<void> clearWishlist() async {
    final box = await getWishlistBox();
    await box.clear();
  }

  // Get wishlist count
  static Future<int> getWishlistCount() async {
    final box = await getWishlistBox();
    return box.keys.where((key) => key.toString().startsWith('product_')).length;
  }
}

