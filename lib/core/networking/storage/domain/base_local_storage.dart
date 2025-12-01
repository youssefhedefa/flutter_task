/// Base interface for local storage operations
/// This provides dependency inversion for different storage implementations
abstract class BaseLocalStorage {
  /// Initialize the storage
  Future<void> init();

  /// Close the storage
  Future<void> close();
}

/// Base interface for CRUD operations on a specific data type
abstract class CrudLocalStorage<T> {
  /// Create or update an item
  Future<void> put(String key, T value);

  /// Read an item by key
  Future<T?> get(String key);

  /// Delete an item by key
  Future<void> delete(String key);

  /// Check if key exists
  Future<bool> containsKey(String key);

  /// Clear all data
  Future<void> clear();

  /// Get all keys
  Future<List<String>> getAllKeys();
}

