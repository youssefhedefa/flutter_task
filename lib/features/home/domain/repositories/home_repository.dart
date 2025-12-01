import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/cached_data.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class HomeRepository {
  Future<ApiResult<CachedData<List<CategoryEntity>>>> getCategories({bool forceRefresh = false});
  Future<ApiResult<List<ProductEntity>>> getProducts({String? category});
}

