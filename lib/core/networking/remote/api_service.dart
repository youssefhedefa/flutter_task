import 'package:dio/dio.dart';
import 'package:flutter_task/core/networking/exceptions/api_exception_handler.dart';
import 'api_result.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<ApiResult<T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return Success(_handleResponse<T>(response));
    } catch (e) {
      return Failure(ApiExceptionHandler.handleException(e));
    }
  }

  Future<ApiResult<T>> post<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return Success(_handleResponse<T>(response));
    } catch (e) {
      return Failure(ApiExceptionHandler.handleException(e));
    }
  }

  T _handleResponse<T>(Response response) {
    final data = response.data;

    if (T == Response) {
      return response as T;
    }

    if (T == dynamic || data is T) {
      return data as T;
    }

    return data as T;
  }
}
