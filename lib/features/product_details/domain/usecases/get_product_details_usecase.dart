import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';
import 'package:flutter_task/features/product_details/domain/repositories/product_details_repository.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository _repository;

  GetProductDetailsUseCase({required ProductDetailsRepository repository})
      : _repository = repository;

  Future<ApiResult<ProductDetailsEntity>> execute(int productId) async {
    return await _repository.getProductDetails(productId);
  }
}

