import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class WishlistRepository {
  Future<ApiResult<List<ProductEntity>>> getWishlistProducts();
  Future<ApiResult<bool>> toggleWishlist(int productId, Map<String, dynamic> productJson);
  Future<ApiResult<List<int>>> getWishlistIds();
  Future<ApiResult<void>> clearWishlist();
}

