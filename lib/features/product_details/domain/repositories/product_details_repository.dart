import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRepository {
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(int productId);
}

