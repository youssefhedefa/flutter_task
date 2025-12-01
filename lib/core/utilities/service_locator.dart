import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/core/networking/remote/dio_factory.dart';
import 'package:flutter_task/core/networking/local/secure_storage_service.dart';
import 'package:flutter_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_task/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_task/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_task/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_task/features/home/domain/usecases/get_products_usecase.dart';
import 'package:flutter_task/features/home/presentaion/cubit/home_cubit.dart';
import 'package:flutter_task/features/splash/domain/usecases/check_auth_usecase.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_cubit.dart';
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

  // Home Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiService: getIt()),
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
}
