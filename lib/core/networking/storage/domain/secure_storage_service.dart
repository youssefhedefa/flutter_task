import 'base_secure_storage.dart';

/// Secure storage service for managing authentication and sensitive data
/// Uses dependency injection to allow different storage implementations
class SecureStorageService {
  final BaseSecureStorage _storage;

  SecureStorageService({required BaseSecureStorage storage})
      : _storage = storage;

  /// Save authentication token
  Future<void> saveToken(String token) async {
    await _storage.saveToken(token);
  }

  /// Retrieve authentication token
  Future<String?> getToken() async {
    return await _storage.getToken();
  }

  /// Delete authentication token
  Future<void> deleteToken() async {
    await _storage.deleteToken();
  }

  /// Clear all secure data
  Future<void> clearAll() async {
    await _storage.clearAll();
  }

  /// Check if authentication token exists
  Future<bool> hasToken() async {
    return await _storage.hasToken();
  }

  /// Write a generic key-value pair
  Future<void> write(String key, String value) async {
    await _storage.write(key, value);
  }

  /// Read a value by key
  Future<String?> read(String key) async {
    return await _storage.read(key);
  }

  /// Delete a value by key
  Future<void> delete(String key) async {
    await _storage.delete(key);
  }

  /// Check if a key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key);
  }
}

