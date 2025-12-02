class UpdateWishlistIdsUseCase {
  Set<int> execute({
    required Set<int> currentWishlistIds,
    required int productId,
    required bool isInWishlist,
  }) {
    final updatedWishlist = Set<int>.from(currentWishlistIds);
    if (isInWishlist) {
      updatedWishlist.add(productId);
    } else {
      updatedWishlist.remove(productId);
    }
    return updatedWishlist;
  }
}

