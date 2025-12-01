import 'package:hive_flutter/hive_flutter.dart';
import '../domain/categories_local_storage.dart';

/// Hive implementation of CategoriesLocalStorage
/// Data layer - contains framework-specific implementation details
class HiveCategoriesStorageImpl implements CategoriesLocalStorage {
  static const String _boxName = 'categories_box';
  static const String _categoriesKey = 'categories';

  Box<List<String>>? _box;

  Future<Box<List<String>>> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }

    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<List<String>>(_boxName);
    } else {
      _box = Hive.box<List<String>>(_boxName);
    }

    return _box!;
  }

  @override
  Future<List<String>?> getCategories() async {
    return await get(_categoriesKey);
  }

  @override
  Future<void> saveCategories(List<String> categories) async {
    await put(_categoriesKey, categories);
  }

  @override
  Future<void> put(String key, List<String> value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  @override
  Future<List<String>?> get(String key) async {
    final box = await _getBox();
    return box.get(key);
  }

  @override
  Future<void> delete(String key) async {
    final box = await _getBox();
    await box.delete(key);
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await _getBox();
    return box.containsKey(key);
  }

  @override
  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  @override
  Future<List<String>> getAllKeys() async {
    final box = await _getBox();
    return box.keys.map((k) => k.toString()).toList();
  }
}

