import 'package:hive_flutter/hive_flutter.dart';
import '../domain/wishlist_local_storage.dart';

class HiveWishlistStorageImpl implements WishlistLocalStorage {
  static const String _boxName = 'wishlist_box';

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

  String _getProductKey(int productId) => 'product_$productId';

  @override
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    final productId = product['id'] as int;
    await put(_getProductKey(productId), product);
  }

  @override
  Future<void> removeFromWishlist(int productId) async {
    await delete(_getProductKey(productId));
  }

  @override
  Future<List<Map<String, dynamic>>> getWishlistProducts() async {
    final box = await _getBox();
    final products = <Map<String, dynamic>>[];

    for (var key in box.keys) {
      if (key.toString().startsWith('product_')) {
        final product = box.get(key);
        if (product is Map) {
          products.add(_convertMap(product));
        }
      }
    }

    return products;
  }

  Map<String, dynamic> _convertMap(Map<dynamic, dynamic> map) {
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

  @override
  Future<List<int>> getWishlistIds() async {
    final products = await getWishlistProducts();
    return products.map((p) => p['id'] as int).toList();
  }

  @override
  Future<bool> isInWishlist(int productId) async {
    return await containsKey(_getProductKey(productId));
  }

  @override
  Future<bool> toggleWishlist(Map<String, dynamic> product) async {
    final productId = product['id'] as int;
    final isInWishlistNow = await isInWishlist(productId);

    if (isInWishlistNow) {
      await removeFromWishlist(productId);
      return false;
    } else {
      await addToWishlist(product);
      return true;
    }
  }

  @override
  Future<int> getWishlistCount() async {
    final box = await _getBox();
    return box.keys.where((key) => key.toString().startsWith('product_')).length;
  }

  @override
  Future<void> put(String key, Map<String, dynamic> value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  @override
  Future<Map<String, dynamic>?> get(String key) async {
    final box = await _getBox();
    final data = box.get(key);
    if (data is Map) {
      return _convertMap(data);
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

