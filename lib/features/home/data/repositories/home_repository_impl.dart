import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/networking/local/hive_service.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/api_routes.dart';
import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/core/networking/remote/cached_data.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/data/models/category_model.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends BaseRepository implements HomeRepository {
  final ApiService _apiService;

  HomeRepositoryImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<ApiResult<CachedData<List<CategoryEntity>>>> getCategories({
    bool forceRefresh = false,
  }) async {
    final apiResult = await executeApiCall<List<CategoryEntity>>(() async {
      final response = await _apiService.get<List<dynamic>>(
        endpoint: ApiRoutes.categories,
      );

      return response.when<ApiResult<List<CategoryEntity>>>(
        success: (data) {
          final categories = data
              .map((json) => CategoryModel.fromJson(json as String))
              .map((model) => CategoryEntity(name: model.name))
              .toList();

          return Success(categories);
        },
        failure: (exception) {
          return Failure(exception);
        },
      );
    });

    if (apiResult is Success<List<CategoryEntity>>) {
      await _saveCategoriesLocally(apiResult.data);
      return Success(CachedData(data: apiResult.data, isFromCache: false));
    }

    if (apiResult is Failure<List<CategoryEntity>>) {
      final cachedCategories = await _getCachedCategories();
      if (cachedCategories != null && cachedCategories.isNotEmpty) {
        return Success(CachedData(data: cachedCategories, isFromCache: true));
      }

      return Failure(apiResult.exception);
    }

    final failure = apiResult as Failure<List<CategoryEntity>>;
    return Failure(failure.exception);
  }

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts({
    String? category,
    int? limit,
    int? skip,
  }) async {
    final categoryKey = category ?? AppStrings.all;

    final cachedProducts = await _getCachedProducts(categoryKey);

    if (cachedProducts != null && cachedProducts.isNotEmpty) {
      // Apply pagination to cached data
      final startIndex = skip ?? 0;
      final endIndex = limit != null ? startIndex + limit : cachedProducts.length;

      final paginatedProducts = cachedProducts
          .skip(startIndex)
          .take(endIndex - startIndex)
          .toList();

      return Success(paginatedProducts);
    }

    // If no cache, fetch from API
    return executeApiCall<List<ProductEntity>>(() async {
      final endpoint = (category == null || category == 'all')
          ? ApiRoutes.products
          : ApiRoutes.productsByCategory(category);

      final response = await _apiService.get<List<dynamic>>(
        endpoint: endpoint,
      );

      return response.when<ApiResult<List<ProductEntity>>>(
        success: (data) {
          final products = ProductMapper.fromJsonList(data);
          _saveProductsLocally(categoryKey, products);
          final startIndex = skip ?? 0;
          final endIndex = limit != null ? startIndex + limit : products.length;

          final paginatedProducts = products
              .skip(startIndex)
              .take(endIndex - startIndex)
              .toList();

          return Success(paginatedProducts);
        },
        failure: (exception) {
          return Failure(exception);
        },
      );
    });
  }

  Future<List<CategoryEntity>?> _getCachedCategories() async {
    try {
      final cachedCategories = await HiveService.getCachedCategories();
      if (cachedCategories != null && cachedCategories.isNotEmpty) {
        return cachedCategories.map((name) => CategoryEntity(name: name)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveCategoriesLocally(List<CategoryEntity> categories) async {
    try {
      final categoryNames = categories.map((c) => c.name).toList();
      await HiveService.saveCategories(categoryNames);
    } catch (e) {
      // Ignore cache errors
    }
  }

  Future<List<ProductEntity>?> _getCachedProducts(String category) async {
    try {
      final cachedData = await HiveService.getCachedProducts(category);
      if (cachedData != null && cachedData.isNotEmpty) {
        return cachedData.map((json) => ProductMapper.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveProductsLocally(
    String category,
    List<ProductEntity> products,
  ) async {
    try {
      // Convert products to JSON format for storage
      final productsJson = products.map((product) {
        return {
          'id': product.id,
          'title': product.title,
          'price': product.price,
          'category': product.category,
          'image': product.image,
          'rating': {
            'rate': product.rating,
            'count': product.ratingCount,
          },
        };
      }).toList();

      await HiveService.saveProducts(category, productsJson);
    } catch (e) {
      // Ignore cache errors
    }
  }
}
