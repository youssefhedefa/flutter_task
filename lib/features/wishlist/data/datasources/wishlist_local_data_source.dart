import 'dart:developer';

import 'package:flutter_task/core/networking/storage/domain/wishlist_local_storage.dart';
import 'package:flutter_task/features/home/data/mappers/product_mapper.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

abstract class WishlistLocalDataSource {
  Future<List<ProductEntity>> getWishlistProducts();
  Future<bool> toggleWishlist(Map<String, dynamic> productJson);
  Future<List<int>> getWishlistIds();
  Future<bool> isInWishlist(int productId);
  Future<int> getWishlistCount();
  Future<void> clearWishlist();
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final WishlistLocalStorage _wishlistStorage;

  WishlistLocalDataSourceImpl({
    required WishlistLocalStorage wishlistStorage,
  }) : _wishlistStorage = wishlistStorage;

  @override
  Future<List<ProductEntity>> getWishlistProducts() async {
    try {
      final wishlistData = await _wishlistStorage.getWishlistProducts();
      if (wishlistData.isEmpty) {
        return [];
      }
      return wishlistData.map((json) {
        return ProductMapper.fromJson(json);
      }).toList();
    } catch (e) {
      log('Error retrieving wishlist products: $e');
      return [];
    }
  }

  @override
  Future<bool> toggleWishlist(Map<String, dynamic> productJson) async {
    try {
      // Ensure the product JSON has all required fields
      if (!productJson.containsKey('description')) {
        productJson['description'] = '';
      }

      final isInWishlist = await _wishlistStorage.toggleWishlist(productJson);
      return isInWishlist;
    } catch (e) {
      log('Error toggling wishlist for product ${productJson['id']}: $e');
      rethrow;
    }
  }

  @override
  Future<List<int>> getWishlistIds() async {
    try {
      return await _wishlistStorage.getWishlistIds();
    } catch (e) {
      log('Error retrieving wishlist IDs: $e');
      return [];
    }
  }

  @override
  Future<bool> isInWishlist(int productId) async {
    try {
      return await _wishlistStorage.isInWishlist(productId);
    } catch (e) {
      log('Error checking if product $productId is in wishlist: $e');
      return false;
    }
  }

  @override
  Future<int> getWishlistCount() async {
    try {
      return await _wishlistStorage.getWishlistCount();
    } catch (e) {
      log('Error getting wishlist count: $e');
      return 0;
    }
  }

  @override
  Future<void> clearWishlist() async {
    try {
      await _wishlistStorage.clear();
    } catch (e) {
      log('Error clearing wishlist: $e');
      rethrow;
    }
  }
}

