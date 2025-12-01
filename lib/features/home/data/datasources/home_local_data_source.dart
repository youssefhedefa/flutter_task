import 'package:flutter_task/core/networking/local/hive_service.dart';
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
  @override
  Future<List<CategoryEntity>?> getCachedCategories() async {
    try {
      final cachedCategories = await HiveService.getCachedCategories();
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
      await HiveService.saveCategories(categoryNames);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<List<ProductEntity>?> getCachedProducts(String category) async {
    try {
      final cachedData = await HiveService.getCachedProducts(category);
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

      await HiveService.saveProducts(category, productsJson);
    } catch (e) {
      // Ignore cache errors
    }
  }
}

