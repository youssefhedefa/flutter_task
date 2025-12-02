import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/features/wishlist/presentation/widgets/wishlist_grid_view.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wishlist),
        centerTitle: true,
      ),
      body: const WishlistGridView(),
    );
  }
}
