import 'package:flutter_task/core/networking/exceptions/api_exception.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:flutter_task/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl extends BaseRepository implements WishlistRepository {
  final WishlistLocalDataSource _localDataSource;

  WishlistRepositoryImpl({
    required WishlistLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlistProducts() async {
    return executeApiCall<List<ProductEntity>>(() async {
      try {
        final wishlistProducts = await _localDataSource.getWishlistProducts();
        return Success(wishlistProducts);
      } catch (e) {
        return Failure(UnknownException(message: e.toString()));
      }
    });
  }

  @override
  Future<ApiResult<bool>> toggleWishlist(
    int productId,
    Map<String, dynamic> productJson,
  ) async {
    return executeApiCall<bool>(() async {
      try {
        final isInWishlist = await _localDataSource.toggleWishlist(productJson);
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
        final wishlistIds = await _localDataSource.getWishlistIds();
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
        await _localDataSource.clearWishlist();
        return const Success(null);
      } catch (e) {
        return Failure(UnknownException(message: e.toString()));
      }
    });
  }
}
