import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlistProductsUseCase {
  final WishlistRepository _repository;

  GetWishlistProductsUseCase({required WishlistRepository repository})
      : _repository = repository;

  Future<ApiResult<List<ProductEntity>>> execute() async {
    return await _repository.getWishlistProducts();
  }
}

