import 'package:flutter_task/core/networking/local/hive_service.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/api_routes.dart';
import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/core/networking/remote/cached_data.dart';
import 'package:flutter_task/core/networking/repository/base_repository.dart';
import 'package:flutter_task/features/home/data/models/category_model.dart';
import 'package:flutter_task/features/home/data/models/product_model.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends BaseRepository implements HomeRepository {
  final ApiService _apiService;

  HomeRepositoryImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<ApiResult<CachedData<List<CategoryEntity>>>> getCategories({bool forceRefresh = false}) async {

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
  Future<ApiResult<List<ProductEntity>>> getProducts({String? category}) async {
    return executeApiCall<List<ProductEntity>>(() async {

      final endpoint = (category == null || category == 'all')
          ? ApiRoutes.products
          : ApiRoutes.productsByCategory(category);

      final response = await _apiService.get<List<dynamic>>(
        endpoint: endpoint,
      );

      return response.when<ApiResult<List<ProductEntity>>>(
        success: (data) {
          final products = data
              .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
              .map((model) => ProductEntity(
                    id: model.id,
                    title: model.title,
                    price: model.price,
                    category: model.category,
                    image: model.image,
                    rating: model.rating.rate,
                    ratingCount: model.rating.count,
                  ))
              .toList();

          return Success(products);
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
        return cachedCategories
            .map((name) => CategoryEntity(name: name))
            .toList();
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
    }
  }
}
