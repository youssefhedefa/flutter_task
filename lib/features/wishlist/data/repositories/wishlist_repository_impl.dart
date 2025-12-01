import 'package:flutter_task/core/networking/exceptions/api_exception.dart';
import 'package:flutter_task/core/networking/local/hive_service.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl extends BaseRepository implements WishlistRepository {

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlistProducts() async {
    return executeApiCall<List<ProductEntity>>(() async {
      try {
        // Get wishlist products directly from HiveService (already complete products)
        final wishlistProductsJson = await HiveService.getWishlistProducts();

        if (wishlistProductsJson.isEmpty) {
          return Success<List<ProductEntity>>([]);
        }

        // Convert to entities
        final wishlistProducts = wishlistProductsJson
            .map((json) => ProductMapper.fromJson(json))
            .toList();

        return Success(wishlistProducts);
      } catch (e) {
        return Failure(UnknownException(message: e.toString()));
      }
    });
  }

  @override
  Future<ApiResult<bool>> toggleWishlist(int productId, Map<String, dynamic> productJson) async {
    return executeApiCall<bool>(() async {
      try {
        final isInWishlist = await HiveService.toggleWishlist(productJson);
        return Success(isInWishlist);
      } catch (e) {
        return Failure(UnknownException(message: e.toString()));
      }
    });
  }

  @override
  Future<ApiResult<List<int>>> getWishlistIds() async {
    return executeApiCall<List<int>>(() async {
      try {
        final wishlistIds = await HiveService.getWishlistIds();
        return Success(wishlistIds);
      } catch (e) {
        return Failure(UnknownException(message: e.toString()));
      }
    });
  }

  @override
  Future<ApiResult<void>> clearWishlist() async {
    return executeApiCall<void>(() async {
      try {
        await HiveService.clearWishlist();
        return const Success(null);
      } catch (e) {
        return Failure(UnknownException(message: e.toString()));
      }
    });
  }
}
