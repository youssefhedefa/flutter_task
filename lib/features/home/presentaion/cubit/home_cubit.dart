import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_task/features/home/domain/usecases/get_products_usecase.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  HomeCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetProductsUseCase getProductsUseCase,
  }) : _getCategoriesUseCase = getCategoriesUseCase,
       _getProductsUseCase = getProductsUseCase,
       super(const HomeState());

  Future<void> init() async {
    await fetchCategories();
    await fetchProducts();
  }

  Future<void> fetchCategories({bool forceRefresh = false}) async {
    emit(
      state.copyWith(
        categoryStatus: RequestStatusEnum.loading,
        productsStatus: RequestStatusEnum.loading,
      ),
    );

    final result = await _getCategoriesUseCase.execute(forceRefresh: forceRefresh);

    result.when(
      success: (cachedData) {
        emit(
          state.copyWith(
            categoryStatus: RequestStatusEnum.success,
            categories: cachedData.data,
            selectedCategory: state.selectedCategory.isEmpty
                ? AppStrings.all
                : state.selectedCategory,
            isFromCache: cachedData.isFromCache,
            errorMessage: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            categoryStatus: RequestStatusEnum.failure,
            errorMessage: error.message,
            isFromCache: state.categories.isNotEmpty ? true : false,
          ),
        );
      },
    );
  }

  Future<void> fetchProducts({bool forceRefresh = false}) async {
    emit(
      state.copyWith(
        productsStatus: RequestStatusEnum.loading,
        currentPage: 1,
        products: [],
        hasMoreProducts: true,
      ),
    );

    final result = await _getProductsUseCase.execute(
      category: state.selectedCategory,
      limit: HomeState.productsPerPage,
      skip: 0,
      forceRefresh: forceRefresh,
    );

    result.when(
      success: (products) {
        final hasMore = products.length == HomeState.productsPerPage;
        emit(
          state.copyWith(
            productsStatus: RequestStatusEnum.success,
            products: products,
            currentPage: 1,
            hasMoreProducts: hasMore,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            productsStatus: RequestStatusEnum.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (state.hasMoreProducts && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final skip = state.currentPage * HomeState.productsPerPage;

      final result = await _getProductsUseCase.execute(
        category: state.selectedCategory,
        limit: HomeState.productsPerPage,
        skip: skip,
      );

      result.when(
        success: (newProducts) {
          final updatedProducts = [...state.products, ...newProducts];
          final hasMore = newProducts.length == HomeState.productsPerPage;
          emit(
            state.copyWith(
              products: updatedProducts,
              currentPage: nextPage,
              isLoadingMore: false,
              hasMoreProducts: hasMore,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copyWith(
              isLoadingMore: false,
              errorMessage: error.message,
            ),
          );
        },
      );
    }
  }

  Future<void> selectCategory(String category) async {
    emit(state.copyWith(selectedCategory: category));
    await fetchProducts();
  }

  void refreshCategories() {
    fetchCategories(forceRefresh: true);
  }

  Future<void> refreshProducts() async {
    await fetchProducts(forceRefresh: true);
  }

  Future<void> refreshAll() async {
    await fetchCategories(forceRefresh: true);
    await fetchProducts(forceRefresh: true);
  }

  void updateWishlistIds(Set<int> wishlistIds) {
    emit(state.copyWith(wishlistIds: wishlistIds));
  }
}
