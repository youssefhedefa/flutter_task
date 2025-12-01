import 'package:hive_flutter/hive_flutter.dart';
import '../domain/base_secure_storage.dart';

/// Basic Hive implementation of secure storage (without encryption)
/// Data layer - contains framework-specific implementation details
/// For production with sensitive data, consider using HiveEncryptedSecureStorageImpl
class HiveSecureStorageImpl implements BaseSecureStorage {
  static const String _boxName = 'secure_storage_box';
  static const String _tokenKey = 'auth_token';

  Box<String>? _box;

  Future<Box<String>> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }

    if (!Hive.isBoxOpen(_boxName)) {
      // Open box without encryption
      _box = await Hive.openBox<String>(_boxName);
    } else {
      _box = Hive.box<String>(_boxName);
    }

    return _box!;
  }

  @override
  Future<void> saveToken(String token) async {
    await write(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return await read(_tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await delete(_tokenKey);
  }

  @override
  Future<void> clearAll() async {
    final box = await _getBox();
    await box.clear();
  }

  @override
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> write(String key, String value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  @override
  Future<String?> read(String key) async {
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
}

