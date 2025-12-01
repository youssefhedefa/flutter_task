import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/cached_data.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase({required HomeRepository repository})
      : _repository = repository;

  Future<ApiResult<CachedData<List<CategoryEntity>>>> execute({bool forceRefresh = false}) async {
    // Simply delegate to repository - it handles cache/API logic
    return await _repository.getCategories(forceRefresh: forceRefresh);
  }
}

