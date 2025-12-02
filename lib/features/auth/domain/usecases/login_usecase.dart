import 'package:flutter_task/core/networking/remote/api_result.dart';
import 'package:flutter_task/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<ApiResult<void>> call({
    required String username,
    required String password,
  }) async {
    return await _authRepository.login(
      username: username,
      password: password,
    );
  }
}

