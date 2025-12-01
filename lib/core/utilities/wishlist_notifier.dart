import 'dart:async';

class WishlistNotifier {
  static final WishlistNotifier _instance = WishlistNotifier._internal();
  factory WishlistNotifier() => _instance;
  WishlistNotifier._internal();

  final _controller = StreamController<Set<int>>.broadcast();

  Stream<Set<int>> get stream => _controller.stream;

  void notify(Set<int> wishlistIds) {
    _controller.add(wishlistIds);
  }

  void dispose() {
    _controller.close();
  }
}
