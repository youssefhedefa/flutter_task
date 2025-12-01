import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/core/networking/remote/dio_factory.dart';
import 'package:flutter_task/core/networking/local/secure_storage_service.dart';
import 'package:flutter_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_task/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_task/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_task/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_task/features/home/domain/usecases/get_products_usecase.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/product_details/data/datasources/product_details_remote_data_source.dart';
import 'package:flutter_task/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:flutter_task/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:flutter_task/features/product_details/domain/usecases/get_product_details_usecase.dart';
import 'package:flutter_task/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter_task/features/splash/domain/usecases/check_auth_usecase.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter_task/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:flutter_task/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/check_product_in_wishlist_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/convert_product_to_json_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/get_wishlist_products_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/get_wishlist_ids_usecase.dart';
import 'package:flutter_task/features/wishlist/domain/usecases/update_wishlist_ids_usecase.dart';
import 'package:flutter_task/features/main_navigation/presentation/cubit/main_navigation_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

initServiceLocator() {
  // Dio
  final dio = DioFactory.getDio();

  // Core Services
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio: dio),
  );

  const secureStorage = FlutterSecureStorage();
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(secureStorage: secureStorage),
  );

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiService: getIt(),
      secureStorageService: getIt(),
    ),
  );

  // Auth Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: getIt()),
  );

  // Auth Cubit
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: getIt(),
    ),
  );

  // Splash Use Cases
  getIt.registerLazySingleton<CheckAuthUseCase>(
    () => CheckAuthUseCase(secureStorageService: getIt()),
  );

  // Splash Cubit
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(
      checkAuthUseCase: getIt(),
    ),
  );

  // Home Data Sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: getIt()),
  );

  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  // Home Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Home Use Cases
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(repository: getIt()),
  );

  // Home Cubit
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getCategoriesUseCase: getIt(),
      getProductsUseCase: getIt(),
    ),
  );

  // Product Details Data Sources
  getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(apiService: getIt()),
  );

  // Product Details Repository
  getIt.registerLazySingleton<ProductDetailsRepository>(
    () => ProductDetailsRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  // Product Details Use Cases
  getIt.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(repository: getIt()),
  );

  // Product Details Cubit
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(
      getProductDetailsUseCase: getIt(),
      toggleWishlistUseCase: getIt(),
      checkProductInWishlistUseCase: getIt(),
      getWishlistIdsUseCase: getIt(),
    ),
  );

  // Wishlist Repository
  getIt.registerLazySingleton<WishlistRepositoryImpl>(
    () => WishlistRepositoryImpl(),
  );

  getIt.registerLazySingleton<WishlistRepository>(
    () => getIt<WishlistRepositoryImpl>(),
  );

  // Wishlist Use Cases
  getIt.registerLazySingleton<GetWishlistProductsUseCase>(
    () => GetWishlistProductsUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<ToggleWishlistUseCase>(
    () => ToggleWishlistUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<GetWishlistIdsUseCase>(
    () => GetWishlistIdsUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<ConvertProductToJsonUseCase>(
    () => ConvertProductToJsonUseCase(),
  );

  getIt.registerLazySingleton<UpdateWishlistIdsUseCase>(
    () => UpdateWishlistIdsUseCase(),
  );

  getIt.registerLazySingleton<CheckProductInWishlistUseCase>(
    () => CheckProductInWishlistUseCase(),
  );

  // Main Navigation Cubit (combines bottom nav and wishlist management)
  getIt.registerFactory<MainNavigationCubit>(
    () => MainNavigationCubit(
      getWishlistIdsUseCase: getIt(),
      getWishlistProductsUseCase: getIt(),
      toggleWishlistUseCase: getIt(),
      convertProductToJsonUseCase: getIt(),
      updateWishlistIdsUseCase: getIt(),
      checkProductInWishlistUseCase: getIt(),
    ),
  );
}
