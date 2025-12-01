import 'base_local_storage.dart';

/// Interface for products local storage operations
/// Domain layer abstraction - no implementation details
abstract class ProductsLocalStorage extends CrudLocalStorage<List<Map<String, dynamic>>> {
  /// Get cached products for a specific category
  Future<List<Map<String, dynamic>>?> getCachedProducts(String category);

  /// Save products for a specific category
  Future<void> saveProducts(String category, List<Map<String, dynamic>> products);

  /// Clear products cache for a specific category
  Future<void> clearProductsCache(String category);

  /// Get all cached products from all categories
  Future<List<Map<String, dynamic>>> getAllCachedProducts();
}

