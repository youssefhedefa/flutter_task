import 'package:flutter_task/features/home/data/models/product_model.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

class ProductMapper {
  ProductMapper._();

  static ProductEntity _toEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      title: model.title,
      price: model.price,
      category: model.category,
      image: model.image,
      rating: model.rating.rate,
      ratingCount: model.rating.count,
    );
  }

  static ProductEntity fromJson(Map<String, dynamic> json) {
    return _toEntity(ProductModel.fromJson(json));
  }

  static List<ProductEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

