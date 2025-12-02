import 'package:flutter_task/core/networking/exceptions/api_exception.dart';
import 'package:flutter_task/core/networking/storage/domain/secure_storage_service.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/core/networking/remote/api_routes.dart';
import 'package:flutter_task/core/networking/remote/api_service.dart';
import 'package:flutter_task/features/auth/data/models/login_model.dart';
import 'package:flutter_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl({
    required ApiService apiService,
    required SecureStorageService secureStorageService,
  }) : _apiService = apiService,
       _secureStorageService = secureStorageService;

  @override
  Future<ApiResult<void>> login({
    required String username,
    required String password,
  }) async {
    final result = await _apiService.post<dynamic>(
      endpoint: ApiRoutes.login,
      data: {
        'username': username,
        'password': password,
      },
    );

    return result.when(
      success: (data) async {
        if (data is! Map<String, dynamic>) {
          return Failure(
            UnauthorizedException(
              message: data,
            ),
          );
        }

        final loginModel = LoginModel.fromJson(data);
        await _secureStorageService.saveToken(loginModel.token);
        return const Success(null);
      },
      failure: (exception) {
        return Failure(exception);
      },
    );
  }
}
