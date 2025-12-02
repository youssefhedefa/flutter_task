import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/home/presentaion/views/home_view.dart';
import 'package:flutter_task/features/wishlist/presentation/views/wishlist_view.dart';

class MainNavigationState extends Equatable {
  final int currentIndex;
  final List<Widget> pages;

  // Wishlist state
  final Set<int> wishlistIds;
  final RequestStatusEnum wishlistStatus;
  final List<ProductEntity> wishlistProducts;
  final String? wishlistErrorMessage;

  const MainNavigationState({
    this.currentIndex = 0,
    this.pages = const [
      HomeView(),
      WishlistView(),
    ],
    this.wishlistIds = const {},
    this.wishlistStatus = RequestStatusEnum.initial,
    this.wishlistProducts = const [],
    this.wishlistErrorMessage,
  });

  MainNavigationState copyWith({
    int? currentIndex,
    Set<int>? wishlistIds,
    RequestStatusEnum? wishlistStatus,
    List<ProductEntity>? wishlistProducts,
    String? wishlistErrorMessage,
  }) {
    return MainNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      pages: pages,
      wishlistIds: wishlistIds ?? this.wishlistIds,
      wishlistStatus: wishlistStatus ?? this.wishlistStatus,
      wishlistProducts: wishlistProducts ?? this.wishlistProducts,
      wishlistErrorMessage: wishlistErrorMessage ?? this.wishlistErrorMessage,
    );
  }

  bool isProductInWishlist(int productId) {
    return wishlistIds.contains(productId);
  }

  @override
  List<Object?> get props => [
        currentIndex,
        pages,
        wishlistIds,
        wishlistStatus,
        wishlistProducts,
        wishlistErrorMessage,
      ];
}

