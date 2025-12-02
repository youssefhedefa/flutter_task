import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/product_details/domain/entities/product_details_entity.dart';

class ProductDetailsState extends Equatable {
  final RequestStatusEnum status;
  final ProductDetailsEntity? productDetails;
  final bool isInWishlist;
  final String? errorMessage;
  final int currentImageIndex;

  const ProductDetailsState({
    this.status = RequestStatusEnum.initial,
    this.productDetails,
    this.isInWishlist = false,
    this.errorMessage,
    this.currentImageIndex = 0,
  });

  ProductDetailsState copyWith({
    RequestStatusEnum? status,
    ProductDetailsEntity? productDetails,
    bool? isInWishlist,
    String? errorMessage,
    int? currentImageIndex,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      productDetails: productDetails ?? this.productDetails,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      errorMessage: errorMessage ?? this.errorMessage,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
    );
  }

  @override
  List<Object?> get props => [
        status,
        productDetails,
        isInWishlist,
        errorMessage,
        currentImageIndex,
      ];
}

