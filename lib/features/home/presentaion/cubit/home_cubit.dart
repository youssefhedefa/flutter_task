import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/networking/local/wishlist_service.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/entities/category_entity.dart';
import 'package:flutter_task/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_task/features/home/domain/usecases/get_products_usecase.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  HomeCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetProductsUseCase getProductsUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _getProductsUseCase = getProductsUseCase,
        super(const HomeState());

  Future<void> init() async {
    await fetchCategories();
    await _loadWishlist();
    await fetchProducts();
  }

  Future<void> fetchCategories({bool forceRefresh = false}) async {
    emit(state.copyWith(categoryStatus: RequestStatusEnum.loading));

    final result = await _getCategoriesUseCase.execute(forceRefresh: forceRefresh);

    result.when(
      success: (cachedData) {
        final allCategories = [
          const CategoryEntity(name: 'all'),
          ...cachedData.data,
        ];

        emit(state.copyWith(
          categoryStatus: RequestStatusEnum.success,
          categories: allCategories,
          selectedCategory: state.selectedCategory.isEmpty ? 'all' : state.selectedCategory,
          isFromCache: cachedData.isFromCache,
          errorMessage: cachedData.isFromCache ? 'Using offline data' : null,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          categoryStatus: RequestStatusEnum.failure,
          errorMessage: error.message,
          isFromCache: false,
        ));
      },
    );
  }

  Future<void> fetchProducts() async {
    emit(state.copyWith(
      productsStatus: RequestStatusEnum.loading,
      displayedProductsCount: HomeState.productsPerPage, // Reset pagination
    ));

    final result = await _getProductsUseCase.execute(
      category: state.selectedCategory,
    );

    result.when(
      success: (products) {
        emit(state.copyWith(
          productsStatus: RequestStatusEnum.success,
          products: products,
          displayedProductsCount: HomeState.productsPerPage,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          productsStatus: RequestStatusEnum.failure,
          errorMessage: error.message,
        ));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (state.hasMoreProducts && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      // Add small delay for better UX with skeleton
      await Future.delayed(const Duration(milliseconds: 1000));

      final newCount = state.displayedProductsCount + HomeState.productsPerPage;
      emit(state.copyWith(
        displayedProductsCount: newCount,
        isLoadingMore: false,
      ));
    }
  }

  Future<void> selectCategory(String category) async {
    emit(state.copyWith(selectedCategory: category));
    await fetchProducts();
  }

  Future<void> _loadWishlist() async {
    final wishlistIds = await WishlistService.getWishlist();
    emit(state.copyWith(wishlistIds: wishlistIds.toSet()));
  }

  Future<void> toggleWishlist(int productId) async {
    final isInWishlist = await WishlistService.toggleWishlist(productId);

    final updatedWishlist = Set<int>.from(state.wishlistIds);
    if (isInWishlist) {
      updatedWishlist.add(productId);
    } else {
      updatedWishlist.remove(productId);
    }

    emit(state.copyWith(wishlistIds: updatedWishlist));
  }

  void refreshCategories() {
    fetchCategories(forceRefresh: true);
  }
}

