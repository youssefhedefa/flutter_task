import 'dart:developer';

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

  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HomeLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<ApiResult<CachedData<List<CategoryEntity>>>> getCategories({
    bool forceRefresh = false,
  }) async {

    // First time OR force refresh → load from API
    if (forceRefresh) {
      final apiResult = await executeApiCall(() async {
        final data = await _remoteDataSource.getCategories();
        return Success(data);
      });

      if (apiResult is Success<List<CategoryEntity>>) {
        await _localDataSource.saveCategories(apiResult.data);
        return Success(CachedData(data: apiResult.data, isFromCache: false));
      }

      // API failed, try cache as fallback
      final cachedFallback = await _localDataSource.getCachedCategories();
      if (cachedFallback != null && cachedFallback.isNotEmpty) {
        return Success(CachedData(data: cachedFallback, isFromCache: true));
      }

      return Failure((apiResult as Failure).exception);
    }

    // Not first time and not force refresh → load from cache
    final cached = await _localDataSource.getCachedCategories();
    if (cached != null && cached.isNotEmpty) {
      return Success(CachedData(data: cached, isFromCache: true));
    }

    // Cache miss, fetch from API
    final apiResult = await executeApiCall(() async {
      final data = await _remoteDataSource.getCategories();
      return Success(data);
    });

    if (apiResult is Success<List<CategoryEntity>>) {
      await _localDataSource.saveCategories(apiResult.data);
      return Success(CachedData(data: apiResult.data, isFromCache: false));
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
    final categoryKey = category ?? AppStrings.all;

    log('Fetching products for "$categoryKey": forceRefresh=$forceRefresh, limit=$limit, skip=$skip');

    // First time for this category OR force refresh → load from API
    if (forceRefresh) {
      final apiResult = await executeApiCall(() async {
        final products = await _remoteDataSource.getProducts(category: category);

        // Save to cache
        await _localDataSource.saveProducts(categoryKey, products);
        return Success(_paginate(products, limit, skip));
      });

      // If API call succeeds, return the result
      if (apiResult is Success<List<ProductEntity>>) {
        return apiResult;
      }

      // API failed, try cache as fallback
      log('API failed for "$categoryKey", falling back to cache');
      final cachedFallback = await _localDataSource.getCachedProducts(categoryKey);
      if (cachedFallback != null && cachedFallback.isNotEmpty) {
        log('Returning cached fallback for "$categoryKey"');
        return Success(_paginate(cachedFallback, limit, skip));
      }

      // No cache available, return the API error
      return apiResult;
    }

    // Not first time and not force refresh → load from cache
    final cached = await _localDataSource.getCachedProducts(categoryKey);
    if (cached != null && cached.isNotEmpty) {
      log('Returning products from cache for "$categoryKey"');
      return Success(_paginate(cached, limit, skip));
    }

    // Cache miss, fetch from API
    log('Cache miss for "$categoryKey", fetching from API');
    final apiResult = await executeApiCall(() async {
      final products = await _remoteDataSource.getProducts(category: category);

      // Save to cache
      await _localDataSource.saveProducts(categoryKey, products);

      return Success(_paginate(products, limit, skip));
    });

    // If API call succeeds, return the result
    if (apiResult is Success<List<ProductEntity>>) {
      return apiResult;
    }

    // API failed and no cache available, return error
    return apiResult;
  }

  /// Paginate a list of products
  /// [list] - The full list of products
  /// [limit] - Maximum number of items to return
  /// [skip] - Number of items to skip from the start
  List<ProductEntity> _paginate(
    List<ProductEntity> list,
    int? limit,
    int? skip,
  ) {
    final skipCount = skip ?? 0;

    log('Paginating: total=${list.length}, skip=$skipCount, limit=$limit');

    // If skip is beyond list length, return empty list
    if (skipCount >= list.length) {
      log('Skip beyond list length, returning empty');
      return [];
    }

    // Skip items and take up to limit
    if (limit != null) {
      final result = list.skip(skipCount).take(limit).toList();
      log('Returning ${result.length} items (limit applied)');
      return result;
    }

    // No limit, return all remaining items
    final result = list.skip(skipCount).toList();
    log('Returning ${result.length} items (no limit)');
    return result;
  }
}
