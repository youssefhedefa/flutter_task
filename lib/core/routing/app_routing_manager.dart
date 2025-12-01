import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/routing/custom_page_route.dart';
import 'package:flutter_task/core/routing/routing_constants.dart';
import 'package:flutter_task/core/utilities/service_locator.dart';
import 'package:flutter_task/features/auth/presentation/views/login_view.dart';
import 'package:flutter_task/features/main_navigation/presentation/views/main_navigation_view.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter_task/features/splash/presentation/views/splash_view.dart';

class AppRoutingManager {
  AppRoutingManager._privateConstructor();

  static final AppRoutingManager _instance = AppRoutingManager._privateConstructor();

  factory AppRoutingManager() {
    return _instance;
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutingConstants.splash:
        return CustomPageRoute(
          child: BlocProvider(
            create: (context) => getIt<SplashCubit>(),
            child: const SplashView(),
          ),
          settings: settings,
        );
      case AppRoutingConstants.login:
        return CustomPageRoute(
          child: const LoginView(),
          settings: settings,
        );
      case AppRoutingConstants.mainNavigation:
        return CustomPageRoute(
          child: const MainNavigationView(),
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
