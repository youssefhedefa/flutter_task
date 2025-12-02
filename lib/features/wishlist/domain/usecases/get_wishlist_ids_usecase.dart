import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlistIdsUseCase {
  final WishlistRepository _repository;

  GetWishlistIdsUseCase({required WishlistRepository repository})
      : _repository = repository;

  Future<ApiResult<List<int>>> execute() async {
    return await _repository.getWishlistIds();
  }
}

