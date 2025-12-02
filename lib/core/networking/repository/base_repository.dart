import 'package:flutter_task/core/networking/exceptions/api_exception_handler.dart';
import 'package:flutter_task/core/networking/remote/api_result.dart';

class BaseRepository {
  Future<ApiResult<T>> executeApiCall<T>(
    Future<ApiResult<T>> Function() apiCall,
  ) async {
    try {
      return await apiCall();
    } catch (e) {

      return Failure(ApiExceptionHandler.handleException(e));
    }
  }
}
