/// Base interface for secure storage operations
/// This provides dependency inversion for different secure storage implementations
abstract class BaseSecureStorage {
  /// Save a token securely
  Future<void> saveToken(String token);

  /// Retrieve a token
  Future<String?> getToken();

  /// Delete a token
  Future<void> deleteToken();

  /// Clear all secure data
  Future<void> clearAll();

  /// Check if a token exists
  Future<bool> hasToken();

  /// Save a key-value pair securely
  Future<void> write(String key, String value);

  /// Read a value by key
  Future<String?> read(String key);

  /// Delete a value by key
  Future<void> delete(String key);

  /// Check if a key exists
  Future<bool> containsKey(String key);
}

