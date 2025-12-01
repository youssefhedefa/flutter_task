import  'package:flutter_task/core/networking/storage/domain/categories_local_storage.dart';
import 'package:flutter_task/core/networking/storage/domain/products_local_storage.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class HomeLocalDataSource {
  Future<List<CategoryEntity>?> getCachedCategories();
  Future<void> saveCategories(List<CategoryEntity> categories);
  Future<List<ProductEntity>?> getCachedProducts(String category);
  Future<void> saveProducts(String category, List<ProductEntity> products);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final CategoriesLocalStorage _categoriesStorage;
  final ProductsLocalStorage _productsStorage;

  HomeLocalDataSourceImpl({
    required CategoriesLocalStorage categoriesStorage,
    required ProductsLocalStorage productsStorage,
  })  : _categoriesStorage = categoriesStorage,
        _productsStorage = productsStorage;

  @override
  Future<List<CategoryEntity>?> getCachedCategories() async {
    try {
      final cachedCategories = await _categoriesStorage.getCategories();
      if (cachedCategories != null && cachedCategories.isNotEmpty) {
        return cachedCategories.map((name) => CategoryEntity(name: name)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveCategories(List<CategoryEntity> categories) async {
    try {
      final categoryNames = categories.map((c) => c.name).toList();
      await _categoriesStorage.saveCategories(categoryNames);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<List<ProductEntity>?> getCachedProducts(String category) async {
    try {
      final cachedData = await _productsStorage.getCachedProducts(category);
      if (cachedData != null && cachedData.isNotEmpty) {
        return cachedData.map((json) => ProductMapper.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveProducts(String category, List<ProductEntity> products) async {
    try {
      // Convert products to JSON format for storage
      final productsJson = products.map((product) {
        return {
          'id': product.id,
          'title': product.title,
          'price': product.price,
          'category': product.category,
          'image': product.image,
          'rating': {
            'rate': product.rating,
            'count': product.ratingCount,
          },
        };
      }).toList();

      await _productsStorage.saveProducts(category, productsJson);
    } catch (e) {
      // Ignore cache errors
    }
  }
}

