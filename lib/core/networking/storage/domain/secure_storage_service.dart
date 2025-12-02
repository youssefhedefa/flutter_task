import 'base_secure_storage.dart';

class SecureStorageService {
  final BaseSecureStorage _storage;

  SecureStorageService({required BaseSecureStorage storage})
      : _storage = storage;

  Future<void> saveToken(String token) async {
    await _storage.saveToken(token);
  }

  Future<String?> getToken() async {
    return await _storage.getToken();
  }

  Future<void> deleteToken() async {
    await _storage.deleteToken();
  }

  Future<void> clearAll() async {
    await _storage.clearAll();
  }

  Future<bool> hasToken() async {
    return await _storage.hasToken();
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key, value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key);
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key);
  }
}

