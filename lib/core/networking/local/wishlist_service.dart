import 'package:hive_flutter/hive_flutter.dart';

class WishlistService {
  static const String _wishlistBoxName = 'wishlist_box';

  // Get wishlist box
  static Future<Box<List<int>>> getWishlistBox() async {
    if (!Hive.isBoxOpen(_wishlistBoxName)) {
      return await Hive.openBox<List<int>>(_wishlistBoxName);
    }
    return Hive.box<List<int>>(_wishlistBoxName);
  }

  // Add product to wishlist
  static Future<void> addToWishlist(int productId) async {
    final box = await getWishlistBox();
    final wishlist = await getWishlist();
    if (!wishlist.contains(productId)) {
      wishlist.add(productId);
      await box.put('wishlist', wishlist);
    }
  }

  // Remove product from wishlist
  static Future<void> removeFromWishlist(int productId) async {
    final box = await getWishlistBox();
    final wishlist = await getWishlist();
    wishlist.remove(productId);
    await box.put('wishlist', wishlist);
  }

  // Get all wishlist product IDs
  static Future<List<int>> getWishlist() async {
    final box = await getWishlistBox();
    return box.get('wishlist') ?? [];
  }

  // Check if product is in wishlist
  static Future<bool> isInWishlist(int productId) async {
    final wishlist = await getWishlist();
    return wishlist.contains(productId);
  }

  // Toggle wishlist status
  static Future<bool> toggleWishlist(int productId) async {
    final isInWishlist = await WishlistService.isInWishlist(productId);
    if (isInWishlist) {
      await removeFromWishlist(productId);
      return false;
    } else {
      await addToWishlist(productId);
      return true;
    }
  }

  // Clear all wishlist
  static Future<void> clearWishlist() async {
    final box = await getWishlistBox();
    await box.delete('wishlist');
  }

  // Get wishlist count
  static Future<int> getWishlistCount() async {
    final wishlist = await getWishlist();
    return wishlist.length;
  }
}

