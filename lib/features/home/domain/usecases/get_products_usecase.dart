import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository _repository;

  GetProductsUseCase({required HomeRepository repository})
      : _repository = repository;

  Future<ApiResult<List<ProductEntity>>> execute({
    String? category,
    int? limit,
    int? skip,
    bool forceRefresh = false,
  }) async {
    return await _repository.getProducts(
      category: category,
      limit: limit,
      skip: skip,
      forceRefresh: forceRefresh,
    );
  }
}

