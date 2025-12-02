abstract class BaseLocalStorage {
  Future<void> init();

  Future<void> close();
}

abstract class CrudLocalStorage<T> {
  Future<void> put(String key, T value);

  Future<T?> get(String key);

  Future<void> delete(String key);

  Future<bool> containsKey(String key);

  Future<void> clear();

  Future<List<String>> getAllKeys();
}

