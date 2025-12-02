import 'package:flutter_task/core/networking/remote/api_result.dart';

abstract class AuthRepository {
  Future<ApiResult<void>> login({
    required String username,
    required String password,
  });
}
