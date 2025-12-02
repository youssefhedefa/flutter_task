import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/cached_data.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends BaseRepository implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;

  bool _firstTimeToFetchCategories = true;

  final Map<String, bool> _firstTimeToFetchProducts = {};

  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HomeLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<ApiResult<CachedData<List<CategoryEntity>>>> getCategories({
    bool forceRefresh = false,
  }) async {
    if (_firstTimeToFetchCategories) {
      _firstTimeToFetchCategories = false;
      final apiResult = await _fetchAndCacheCategories();

      if (apiResult is Success<List<CategoryEntity>>) {
        return Success(
          CachedData(
            data: apiResult.data,
            isFromCache: false,
          ),
        );
      }

      return await _fallbackCategories(apiResult);
    }

    if (forceRefresh) {
      final apiResult = await _fetchAndCacheCategories();

      if (apiResult is Success<List<CategoryEntity>>) {
        return Success(
          CachedData(
            data: apiResult.data,
            isFromCache: false,
          ),
        );
      }

      return await _fallbackCategories(apiResult);
    }

    final cached = await _localDataSource.getCachedCategories();
    if (cached != null && cached.isNotEmpty) {
      return Success(
        CachedData(
          data: cached,
          isFromCache: true,
        ),
      );
    }

    final apiResult = await _fetchAndCacheCategories();
    if (apiResult is Success<List<CategoryEntity>>) {
      return Success(
        CachedData(
          data: apiResult.data,
          isFromCache: false,
        ),
      );
    }

    return Failure((apiResult as Failure).exception);
  }

  Future<ApiResult<List<CategoryEntity>>> _fetchAndCacheCategories() async {
    return await executeApiCall(() async {
      final remote = await _remoteDataSource.getCategories();
      await _localDataSource.saveCategories(remote);
      return Success(remote);
    });
  }

  Future<ApiResult<CachedData<List<CategoryEntity>>>> _fallbackCategories(
    ApiResult apiResult,
  ) async {
    final fallback = await _localDataSource.getCachedCategories();

    if (fallback != null && fallback.isNotEmpty) {
      return Success(
        CachedData(
          data: fallback,
          isFromCache: true,
        ),
      );
    }

    return Failure((apiResult as Failure).exception);
  }

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts({
    String? category,
    int? limit,
    int? skip,
    bool forceRefresh = false,
  }) async {
    final String categoryKey = category ?? AppStrings.all;
    if (_firstTimeToFetchProducts[categoryKey] != false) {
      _firstTimeToFetchProducts[categoryKey] = false;

      final apiResult = await _fetchAndCacheProducts(categoryKey, category);

      if (apiResult is Success<List<ProductEntity>>) {
        return Success(_paginate(apiResult.data, limit, skip));
      }

      return await _fallbackProducts(
        apiResult,
        categoryKey,
        limit,
        skip,
      );
    }
    if (forceRefresh) {
      final apiResult = await _fetchAndCacheProducts(categoryKey, category);

      if (apiResult is Success<List<ProductEntity>>) {
        return Success(_paginate(apiResult.data, limit, skip));
      }

      return await _fallbackProducts(
        apiResult,
        categoryKey,
        limit,
        skip,
      );
    }

    final cached = await _localDataSource.getCachedProducts(categoryKey);
    if (cached != null && cached.isNotEmpty) {
      return Success(_paginate(cached, limit, skip));
    }

    final apiResult = await _fetchAndCacheProducts(categoryKey, category);
    if (apiResult is Success<List<ProductEntity>>) {
      return Success(_paginate(apiResult.data, limit, skip));
    }

    return apiResult;
  }

  Future<ApiResult<List<ProductEntity>>> _fetchAndCacheProducts(
    String categoryKey,
    String? category,
  ) async {
    return await executeApiCall(() async {
      final remote = await _remoteDataSource.getProducts(category: category);

      await _localDataSource.saveProducts(categoryKey, remote);

      return Success(remote);
    });
  }

  Future<ApiResult<List<ProductEntity>>> _fallbackProducts(
    ApiResult apiResult,
    String categoryKey,
    int? limit,
    int? skip,
  ) async {
    final fallback = await _localDataSource.getCachedProducts(categoryKey);

    if (fallback != null && fallback.isNotEmpty) {
      return Success(_paginate(fallback, limit, skip));
    }

    return Failure((apiResult as Failure).exception);
  }

  List<ProductEntity> _paginate(
    List<ProductEntity> list,
    int? limit,
    int? skip,
  ) {
    final int s = skip ?? 0;

    if (s >= list.length) return [];

    if (limit != null) {
      return list.skip(s).take(limit).toList();
    }

    return list.skip(s).toList();
  }
}
