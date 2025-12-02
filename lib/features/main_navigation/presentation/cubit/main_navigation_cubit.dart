import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/check_product_in_wishlist_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/convert_product_to_json_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/get_wishlist_ids_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/get_wishlist_products_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/update_wishlist_ids_usecase.dart';
import 'main_navigation_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  final GetWishlistIdsUseCase _getWishlistIdsUseCase;
  final GetWishlistProductsUseCase _getWishlistProductsUseCase;
  final ToggleWishlistUseCase _toggleWishlistUseCase;
  final ConvertProductToJsonUseCase _convertProductToJsonUseCase;
  final UpdateWishlistIdsUseCase _updateWishlistIdsUseCase;
  final CheckProductInWishlistUseCase _checkProductInWishlistUseCase;

  MainNavigationCubit({
    required GetWishlistIdsUseCase getWishlistIdsUseCase,
    required GetWishlistProductsUseCase getWishlistProductsUseCase,
    required ToggleWishlistUseCase toggleWishlistUseCase,
    required ConvertProductToJsonUseCase convertProductToJsonUseCase,
    required UpdateWishlistIdsUseCase updateWishlistIdsUseCase,
    required CheckProductInWishlistUseCase checkProductInWishlistUseCase,
  }) : _getWishlistIdsUseCase = getWishlistIdsUseCase,
       _getWishlistProductsUseCase = getWishlistProductsUseCase,
       _toggleWishlistUseCase = toggleWishlistUseCase,
       _convertProductToJsonUseCase = convertProductToJsonUseCase,
       _updateWishlistIdsUseCase = updateWishlistIdsUseCase,
       _checkProductInWishlistUseCase = checkProductInWishlistUseCase,
       super(const MainNavigationState()) {
    _loadWishlistIds();
  }

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
    if (index == 1) {
      fetchWishlistProducts();
    }
  }

  Future<void> _loadWishlistIds() async {
    final result = await _getWishlistIdsUseCase.execute();

    result.when(
      success: (wishlistIds) {
        emit(
          state.copyWith(
            wishlistIds: wishlistIds.toSet(),
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(wishlistIds: <int>{}));
      },
    );
  }

  Future<void> fetchWishlistProducts() async {
    emit(state.copyWith(wishlistStatus: RequestStatusEnum.loading));

    final result = await _getWishlistProductsUseCase.execute();

    result.when(
      success: (products) {
        final wishlistIds = products.map((p) => p.id).toSet();
        emit(
          state.copyWith(
            wishlistStatus: RequestStatusEnum.success,
            wishlistProducts: products,
            wishlistIds: wishlistIds,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            wishlistStatus: RequestStatusEnum.failure,
            wishlistErrorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> toggleWishlist(ProductEntity product) async {
    final productJson = _convertProductToJsonUseCase.execute(product);

    final result = await _toggleWishlistUseCase.execute(product.id, productJson);

    result.when(
      success: (isInWishlist) {
        final updatedWishlist = _updateWishlistIdsUseCase.execute(
          currentWishlistIds: state.wishlistIds,
          productId: product.id,
          isInWishlist: isInWishlist,
        );
        emit(state.copyWith(wishlistIds: updatedWishlist));
        if (state.currentIndex == 1) {
          fetchWishlistProducts();
        }
      },
      failure: (error) {
        emit(
          state.copyWith(
            wishlistErrorMessage: error.message,
          ),
        );
      },
    );
  }

  bool isInWishlist(int productId) {
    return _checkProductInWishlistUseCase.execute(
      wishlistIds: state.wishlistIds,
      productId: productId,
    );
  }

  Future<void> refreshWishlist() async {
    await _loadWishlistIds();
    if (state.currentIndex == 1) {
      await fetchWishlistProducts();
    }
  }
}
