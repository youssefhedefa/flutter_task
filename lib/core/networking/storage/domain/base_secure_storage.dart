abstract class BaseSecureStorage {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();

  Future<void> clearAll();

  Future<bool> hasToken();

  Future<void> write(String key, String value);

  Future<String?> read(String key);

  Future<void> delete(String key);

  Future<bool> containsKey(String key);
}

