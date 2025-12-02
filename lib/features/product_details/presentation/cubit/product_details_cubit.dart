import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/product_details/domain/usecases/get_product_details_usecase.dart';
import 'package:flutter_task/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/check_product_in_wishlist_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/get_wishlist_ids_usecase.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final ToggleWishlistUseCase _toggleWishlistUseCase;
  final CheckProductInWishlistUseCase _checkProductInWishlistUseCase;
  final GetWishlistIdsUseCase _getWishlistIdsUseCase;

  bool _wishlistStateChanged = false;

  ProductDetailsCubit({
    required GetProductDetailsUseCase getProductDetailsUseCase,
    required ToggleWishlistUseCase toggleWishlistUseCase,
    required CheckProductInWishlistUseCase checkProductInWishlistUseCase,
    required GetWishlistIdsUseCase getWishlistIdsUseCase,
  })  : _getProductDetailsUseCase = getProductDetailsUseCase,
        _toggleWishlistUseCase = toggleWishlistUseCase,
        _checkProductInWishlistUseCase = checkProductInWishlistUseCase,
        _getWishlistIdsUseCase = getWishlistIdsUseCase,
        super(const ProductDetailsState());

  bool get hasWishlistChanged => _wishlistStateChanged;

  Future<void> fetchProductDetails(int productId) async {
    emit(state.copyWith(status: RequestStatusEnum.loading));

    final result = await _getProductDetailsUseCase.execute(productId);

    result.when(
      success: (productDetails) async {
        // Check if product is in wishlist
        final wishlistResult = await _getWishlistIdsUseCase.execute();
        final isInWishlist = wishlistResult.when(
          success: (wishlistIds) => _checkProductInWishlistUseCase.execute(
            wishlistIds: wishlistIds.toSet(),
            productId: productId,
          ),
          failure: (_) => false,
        );

        emit(
          state.copyWith(
            status: RequestStatusEnum.success,
            productDetails: productDetails,
            isInWishlist: isInWishlist,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: RequestStatusEnum.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> toggleWishlist() async {
    if (state.productDetails == null) return;

    final productDetails = state.productDetails!;
    final newWishlistState = !state.isInWishlist;

    // Update UI immediately for better UX
    emit(state.copyWith(isInWishlist: newWishlistState));
    _wishlistStateChanged = true;

    // Convert product details to JSON for storage
    final productJson = {
      'id': productDetails.id,
      'title': productDetails.title,
      'price': productDetails.price,
      'description': productDetails.description,
      'category': productDetails.category,
      'image': productDetails.image,
      'rating': {
        'rate': productDetails.rating,
        'count': productDetails.ratingCount,
      },
    };

    // Toggle in background
    await _toggleWishlistUseCase.execute(productDetails.id, productJson);
  }

  void updateImageIndex(int index) {
    emit(state.copyWith(currentImageIndex: index));
  }
}

