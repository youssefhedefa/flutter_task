import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

class ConvertProductToJsonUseCase {
  Map<String, dynamic> execute(ProductEntity product) {
    return {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'description': '',
      'category': product.category,
      'image': product.image,
      'rating': {
        'rate': product.rating,
        'count': product.ratingCount,
      },
    };
  }
}

