import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/cached_data.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase({required HomeRepository repository})
      : _repository = repository;

  Future<ApiResult<CachedData<List<CategoryEntity>>>> execute({
    bool forceRefresh = false,
  }) async {
    final result = await _repository.getCategories(forceRefresh: forceRefresh);

    return result.when(
      success: (cachedData) {
        // Add "all" category at the beginning
        final allCategories = [
          const CategoryEntity(name: AppStrings.all),
          ...cachedData.data,
        ];

        return Success(
          CachedData(
            data: allCategories,
            isFromCache: cachedData.isFromCache,
          ),
        );
      },
      failure: (exception) => Failure(exception),
    );
  }
}

