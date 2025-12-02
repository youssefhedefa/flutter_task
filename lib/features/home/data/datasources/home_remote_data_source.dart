import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/networking/remote/api_routes.dart';
import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/data/models/category_model.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryEntity>> getCategories();
  Future<List<ProductEntity>> getProducts({String? category});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await _apiService.get<List<dynamic>>(
      endpoint: ApiRoutes.categories,
    );

    return response.when<List<CategoryEntity>>(
      success: (data) {
        final categories = data
            .map((json) => CategoryModel.fromJson(json as String))
            .map((model) => CategoryEntity(name: model.name))
            .toList();

        return categories;
      },
      failure: (exception) {
        throw exception;
      },
    );
  }

  @override
  Future<List<ProductEntity>> getProducts({String? category}) async {
    final endpoint = (category == null || category == AppStrings.all)
        ? ApiRoutes.products
        : ApiRoutes.productsByCategory(category);

    final response = await _apiService.get<List<dynamic>>(
      endpoint: endpoint,
    );

    return response.when<List<ProductEntity>>(
      success: (data) {
        final products = ProductMapper.fromJsonList(data);
        return products;
      },
      failure: (exception) {
        throw exception;
      },
    );
  }
}

