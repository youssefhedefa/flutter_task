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
  final bool hasMoreProducts;
  final int currentPage;
  final int productsPerPage = 8;

  const HomeState({
    this.categoryStatus = RequestStatusEnum.initial,
    this.categories = const [],
    this.selectedCategory = 'all',
    this.errorMessage,
    this.isFromCache = false,
    this.productsStatus = RequestStatusEnum.initial,
    this.products = const [],
    this.wishlistIds = const {},
    this.hasMoreProducts = true,
    this.currentPage = 1,
  });

  // Computed property for checking if loading more
  bool get isLoadingMore => productsStatus == RequestStatusEnum.loadingMore;

  HomeState copyWith({
    RequestStatusEnum? categoryStatus,
    List<CategoryEntity>? categories,
    String? selectedCategory,
    String? errorMessage,
    bool? isFromCache,
    RequestStatusEnum? productsStatus,
    List<ProductEntity>? products,
    Set<int>? wishlistIds,
    bool? hasMoreProducts,
    int? currentPage,
  }) {
    return HomeState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
      isFromCache: isFromCache ?? this.isFromCache,
      productsStatus: productsStatus ?? this.productsStatus,
      products: products ?? this.products,
      wishlistIds: wishlistIds ?? this.wishlistIds,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        categoryStatus,
        categories,
        selectedCategory,
        errorMessage,
        isFromCache,
        productsStatus,
        products,
        wishlistIds,
        hasMoreProducts,
        currentPage,
      ];
}

