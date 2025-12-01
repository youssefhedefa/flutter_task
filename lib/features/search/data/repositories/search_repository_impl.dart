import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/search/data/datasources/search_local_data_source.dart';
import 'package:flutter_task/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends BaseRepository implements SearchRepository {
  final SearchLocalDataSource _localDataSource;

  SearchRepositoryImpl({
    required SearchLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<ApiResult<List<ProductEntity>>> searchProducts(String query) async {
    return executeApiCall(() async {
      final products = await _localDataSource.searchProductsLocally(query);
      return Success(products);
    });
  }
}

