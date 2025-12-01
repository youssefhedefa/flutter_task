class CheckProductInWishlistUseCase {
  bool execute({
    required Set<int> wishlistIds,
    required int productId,
  }) {
    return wishlistIds.contains(productId);
  }
}

