import 'package:flutter/material.dart';

class EmptyProductsWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyProductsWidget({
    super.key,
    this.message = 'No products found',
    this.icon = Icons.shopping_bag_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

