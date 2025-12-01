import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class SearchRepository {
  Future<ApiResult<List<ProductEntity>>> searchProducts(String query);
}

