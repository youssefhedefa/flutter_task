import 'package:flutter_task/core/networking/remote/api_routes.dart';
import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/features/product_details/data/mappers/product_details_mapper.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsEntity> getProductDetails(int productId);
}

class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSource {
  final ApiService _apiService;

  ProductDetailsRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<ProductDetailsEntity> getProductDetails(int productId) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      endpoint: ApiRoutes.productDetails(productId),
    );

    return response.when<ProductDetailsEntity>(
      success: (data) {
        return ProductDetailsMapper.fromJson(data);
      },
      failure: (exception) {
        throw exception;
      },
    );
  }
}

