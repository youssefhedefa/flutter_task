import 'base_local_storage.dart';

abstract class ProductsLocalStorage extends CrudLocalStorage<List<Map<String, dynamic>>> {
  Future<List<Map<String, dynamic>>?> getCachedProducts(String category);

  Future<void> saveProducts(String category, List<Map<String, dynamic>> products);

  Future<void> clearProductsCache(String category);

  Future<List<Map<String, dynamic>>> getAllCachedProducts();
}

