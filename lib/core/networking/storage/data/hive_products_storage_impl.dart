import 'package:hive_flutter/hive_flutter.dart';
import '../domain/products_local_storage.dart';

class HiveProductsStorageImpl implements ProductsLocalStorage {
  static const String _boxName = 'products_box';

  Box<dynamic>? _box;

  Future<Box<dynamic>> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }

    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox(_boxName);
    } else {
      _box = Hive.box(_boxName);
    }

    return _box!;
  }

  String _getCategoryKey(String category) => 'products_$category';

  @override
  Future<List<Map<String, dynamic>>?> getCachedProducts(String category) async {
    return await get(_getCategoryKey(category));
  }

  @override
  Future<void> saveProducts(
    String category,
    List<Map<String, dynamic>> products,
  ) async {
    await put(_getCategoryKey(category), products);
  }

  @override
  Future<void> clearProductsCache(String category) async {
    await delete(_getCategoryKey(category));
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCachedProducts() async {
    final box = await _getBox();
    final allProducts = <Map<String, dynamic>>[];

    for (var key in box.keys) {
      if (key.toString().startsWith('products_')) {
        final data = box.get(key);
        if (data != null && data is List) {
          for (var item in data) {
            if (item is Map) {
              allProducts.add(_convertMap(item));
            }
          }
        }
      }
    }

    return allProducts;
  }
  Map<String, dynamic> _convertMap(Map<dynamic, dynamic> map) {
    final result = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        result[key.toString()] = _convertMap(value);
      } else {
        result[key.toString()] = value;
      }
    });
    return result;
  }

  @override
  Future<void> put(String key, List<Map<String, dynamic>> value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  @override
  Future<List<Map<String, dynamic>>?> get(String key) async {
    final box = await _getBox();
    final data = box.get(key);
    if (data != null && data is List) {
      return data.map((item) {
        if (item is Map<dynamic, dynamic>) {
          return _convertMap(item);
        } else if (item is Map<String, dynamic>) {
          return item;
        }
        throw Exception('Invalid data type in cache: ${item.runtimeType}');
      }).toList();
    }
    return null;
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

