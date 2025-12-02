import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/search/domain/repositories/search_repository.dart';

class SearchProductsUseCase {
  final SearchRepository _repository;

  SearchProductsUseCase({required SearchRepository repository})
      : _repository = repository;

  Future<ApiResult<List<ProductEntity>>> execute(String query) async {
    if (query.trim().isEmpty) {
      return const Success([]);
    }
    return await _repository.searchProducts(query);
  }
}

