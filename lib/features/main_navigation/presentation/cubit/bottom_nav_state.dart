import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/features/home/presentaion/views/home_view.dart';
import 'package:flutter_task/features/wishlist/presentation/views/wishlist_view.dart';

class BottomNavState extends Equatable {
  final int currentIndex;
  final List<Widget> pages;

  const BottomNavState({
    this.currentIndex = 0,
    this.pages = const [
      HomeView(),
      WishlistView(),
    ],
  });

  BottomNavState copyWith({
    int? currentIndex,
  }) {
    return BottomNavState(
      currentIndex: currentIndex ?? this.currentIndex,
      pages: pages,
    );
  }

  @override
  List<Object?> get props => [currentIndex, pages];
}
