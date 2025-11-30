import 'package:flutter/material.dart';
import 'package:flutter_task/core/routing/custom_page_route.dart';
import 'package:flutter_task/core/routing/routing_constants.dart';

class AppRoutingManager {
  AppRoutingManager._privateConstructor();

  static final AppRoutingManager _instance = AppRoutingManager._privateConstructor();

  factory AppRoutingManager() {
    return _instance;
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutingConstants.auth:
        return CustomPageRoute(
          child: const Scaffold(
            body: Center(
              child: Text('Auth View'),
            ),
          ),
          settings: settings,
        );
      case AppRoutingConstants.home:
        return CustomPageRoute(
          child: const Scaffold(
            body: Center(
              child: Text('Home View'),
            ),
          ),
          settings: settings,
        );
      case AppRoutingConstants.productDetails:
        return CustomPageRoute(
          child: const Scaffold(
            body: Center(
              child: Text('Product Details View'),
            ),
          ),
          settings: settings,
        );
      case AppRoutingConstants.search:
        return CustomPageRoute(
          child: const Scaffold(
            body: Center(
              child: Text('Search View'),
            ),
          ),
          settings: settings,
        );
      case AppRoutingConstants.wishingList:
        return CustomPageRoute(
          child: const Scaffold(
            body: Center(
              child: Text('Wishing List View'),
            ),
          ),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
