import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _categoriesBoxName = 'categories_box';
  static const String _productsBoxName = 'products_box';
  static const String _wishlistBoxName = 'wishlist_box';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  // Get categories box
  static Future<Box<List<String>>> getCategoriesBox() async {
    if (!Hive.isBoxOpen(_categoriesBoxName)) {
      return await Hive.openBox<List<String>>(_categoriesBoxName);
    }
    return Hive.box<List<String>>(_categoriesBoxName);
  }

  // Save categories
  static Future<void> saveCategories(List<String> categories) async {
    final box = await getCategoriesBox();
    await box.put('categories', categories);
  }

  // Get cached categories
  static Future<List<String>?> getCachedCategories() async {
    final box = await getCategoriesBox();
    return box.get('categories');
  }

  // Clear categories cache
  static Future<void> clearCategoriesCache() async {
    final box = await getCategoriesBox();
    await box.delete('categories');
  }

  // Get products box
  static Future<Box<dynamic>> getProductsBox() async {
    if (!Hive.isBoxOpen(_productsBoxName)) {
      return await Hive.openBox(_productsBoxName);
    }
    return Hive.box(_productsBoxName);
  }

  // Save products for a category
  static Future<void> saveProducts(String category, List<Map<String, dynamic>> products) async {
    final box = await getProductsBox();
    await box.put('products_$category', products);
  }

  // Get cached products for a category
  static Future<List<Map<String, dynamic>>?> getCachedProducts(String category) async {
    final box = await getProductsBox();
    final data = box.get('products_$category');
    if (data != null && data is List) {
      return data.cast<Map<String, dynamic>>();
    }
    return null;
  }

  // Clear products cache for a specific category
  static Future<void> clearProductsCache(String category) async {
    final box = await getProductsBox();
    await box.delete('products_$category');
  }

  // Clear all products cache
  static Future<void> clearAllProductsCache() async {
    final box = await getProductsBox();
    await box.clear();
  }

  // Close all boxes
  static Future<void> closeAll() async {
    await Hive.close();
  }

  // ==================== Wishlist Methods ====================

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
          // Recursively convert Map<dynamic, dynamic> to Map<String, dynamic>
          products.add(_convertMap(product));
        }
      }
    }

    return products;
  }

  // Helper method to convert Map<dynamic, dynamic> to Map<String, dynamic>
  static Map<String, dynamic> _convertMap(Map<dynamic, dynamic> map) {
    final result = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        // Recursively convert nested maps
        result[key.toString()] = _convertMap(value);
      } else {
        result[key.toString()] = value;
      }
    });
    return result;
  }

  // Get all wishlist product IDs
  static Future<List<int>> getWishlistIds() async {
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
    final isInWishlist = await HiveService.isInWishlist(productId);
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

