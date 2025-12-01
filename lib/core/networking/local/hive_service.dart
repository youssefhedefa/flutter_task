import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _categoriesBoxName = 'categories_box';

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

  // Close all boxes
  static Future<void> closeAll() async {
    await Hive.close();
  }
}

