import 'dart:developer';

import 'package:flutter_task/core/networking/local/hive_service.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class SearchLocalDataSource {
  Future<List<ProductEntity>> searchProductsLocally(String query);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  @override
  Future<List<ProductEntity>> searchProductsLocally(String query) async {
    try {
      final allProducts = await HiveService.getAllCachedProducts();

      if (allProducts.isEmpty) {
        return [];
      }

      final searchQuery = query.toLowerCase().trim();

      // Filter products based on title or category
      final filteredProducts = allProducts.where((productJson) {
        final title = (productJson['title'] as String?)?.toLowerCase() ?? '';
        final category = (productJson['category'] as String?)?.toLowerCase() ?? '';

        return title.contains(searchQuery) || category.contains(searchQuery);
      }).toList();

      // Remove duplicates by id
      final uniqueProducts = <int, Map<String, dynamic>>{};
      for (var product in filteredProducts) {
        final id = product['id'] as int;
        // Ensure description field exists (cached products might not have it)
        if (!product.containsKey('description') || product['description'] == null) {
          product['description'] = '';
        }
        uniqueProducts[id] = product;
      }

      return uniqueProducts.values
          .map((json) => ProductMapper.fromJson(json))
          .toList();
    } catch (e) {
      log('Error searching products locally: $e');
      return [];
    }
  }
}
