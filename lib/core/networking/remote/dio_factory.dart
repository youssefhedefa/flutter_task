import 'package:dio/dio.dart';
import 'package:flutter_task/core/networking/remote/api_routes.dart';
import 'api_constants.dart';
import 'dio_interceptors.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) return _dio!;

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
        responseType: ResponseType.json,
        validateStatus: (status) {
          // Accept any status code
          return status != null && status < 500;
        },
      ),
    );

    _addInterceptors();

    return _dio!;
  }

  static void _addInterceptors() {
    _dio!.interceptors.add(DioInterceptors.getAuthInterceptor());
    _dio!.interceptors.add(DioInterceptors.getLoggingInterceptor());
  }


  static void reset() {
    _dio?.close();
    _dio = null;
  }
}

