import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _categoriesBoxName = 'categories_box';
  static const String _productsBoxName = 'products_box';

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
}

