import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/wishlist/domain/repositories/wishlist_repository.dart';

class ToggleWishlistUseCase {
  final WishlistRepository _repository;

  ToggleWishlistUseCase({required WishlistRepository repository})
      : _repository = repository;

  Future<ApiResult<bool>> execute(int productId, Map<String, dynamic> productJson) async {
    return await _repository.toggleWishlist(productId, productJson);
  }
}

