import 'base_local_storage.dart';

/// Interface for categories local storage operations
/// Domain layer abstraction - no implementation details
abstract class CategoriesLocalStorage extends CrudLocalStorage<List<String>> {
  /// Get cached categories
  Future<List<String>?> getCategories();

  /// Save categories to cache
  Future<void> saveCategories(List<String> categories);
}

