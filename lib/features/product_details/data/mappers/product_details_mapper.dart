import 'package:flutter_task/features/product_details/data/models/product_details_model.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';

class ProductDetailsMapper {
  ProductDetailsMapper._();

  static ProductDetailsEntity _toEntity(ProductDetailsModel model) {
    return ProductDetailsEntity(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: model.rating.rate,
      ratingCount: model.rating.count,
    );
  }

  static ProductDetailsEntity fromJson(Map<dynamic, dynamic> json) {
    return _toEntity(ProductDetailsModel.fromJson(json));
  }
}

