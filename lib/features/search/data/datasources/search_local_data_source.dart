import 'dart:developer';
import 'package:flutter_task/core/networking/storage/domain/products_local_storage.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class SearchLocalDataSource {
  Future<List<ProductEntity>> searchProductsLocally(String query);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final ProductsLocalStorage _productsStorage;

  SearchLocalDataSourceImpl({
    required ProductsLocalStorage productsStorage,
  }) : _productsStorage = productsStorage;

  @override
  Future<List<ProductEntity>> searchProductsLocally(String query) async {
    try {
      final allProducts = await _productsStorage.getAllCachedProducts();

      if (allProducts.isEmpty) {
        return [];
      }

      final searchQuery = query.toLowerCase().trim();

      final filteredProducts = allProducts.where((productJson) {
        final title = (productJson['title'] as String?)?.toLowerCase() ?? '';
        final category = (productJson['category'] as String?)?.toLowerCase() ?? '';

        return title.contains(searchQuery) || category.contains(searchQuery);
      }).toList();

      final uniqueProducts = <int, Map<String, dynamic>>{};
      for (var product in filteredProducts) {
        final id = product['id'] as int;
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
