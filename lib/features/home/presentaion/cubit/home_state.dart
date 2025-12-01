import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

class HomeState extends Equatable {
  final RequestStatusEnum categoryStatus;
  final List<CategoryEntity> categories;
  final String selectedCategory;
  final String? errorMessage;
  final bool isFromCache;

  // Products
  final RequestStatusEnum productsStatus;
  final List<ProductEntity> products;
  final Set<int> wishlistIds;

  // Pagination
  final int displayedProductsCount;
  final bool isLoadingMore;
  static const int productsPerPage = 8;

  const HomeState({
    this.categoryStatus = RequestStatusEnum.initial,
    this.categories = const [],
    this.selectedCategory = 'all',
    this.errorMessage,
    this.isFromCache = false,
    this.productsStatus = RequestStatusEnum.initial,
    this.products = const [],
    this.wishlistIds = const {},
    this.displayedProductsCount = productsPerPage,
    this.isLoadingMore = false,
  });

  List<ProductEntity> get displayedProducts {
    final count = displayedProductsCount > products.length
        ? products.length
        : displayedProductsCount;
    return products.take(count).toList();
  }

  bool get hasMoreProducts => displayedProductsCount < products.length;

  HomeState copyWith({
    RequestStatusEnum? categoryStatus,
    List<CategoryEntity>? categories,
    String? selectedCategory,
    String? errorMessage,
    bool? isFromCache,
    RequestStatusEnum? productsStatus,
    List<ProductEntity>? products,
    bool? isLoadingMore,
    Set<int>? wishlistIds,
    int? displayedProductsCount,
  }) {
    return HomeState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
      isFromCache: isFromCache ?? this.isFromCache,
      productsStatus: productsStatus ?? this.productsStatus,
      products: products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      wishlistIds: wishlistIds ?? this.wishlistIds,
      displayedProductsCount: displayedProductsCount ?? this.displayedProductsCount,
    );
  }

  @override
  List<Object?> get props => [
        categoryStatus,
        categories,
        selectedCategory,
        errorMessage,
        isFromCache,
        isLoadingMore,
        productsStatus,
        products,
        wishlistIds,
        displayedProductsCount,
      ];
}

