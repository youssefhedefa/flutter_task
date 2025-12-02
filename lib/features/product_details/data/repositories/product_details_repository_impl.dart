import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/product_details/data/datasources/product_details_remote_data_source.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';
import 'package:flutter_task/features/product_details/domain/repositories/product_details_repository.dart';

class ProductDetailsRepositoryImpl extends BaseRepository implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource _remoteDataSource;

  ProductDetailsRepositoryImpl({
    required ProductDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(int productId) async {
    return executeApiCall(() async {
      final productDetails = await _remoteDataSource.getProductDetails(productId);
      return Success(productDetails);
    });
  }
}

