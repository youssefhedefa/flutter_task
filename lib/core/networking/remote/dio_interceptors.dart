import 'dart:developer';

import 'package:dio/dio.dart';

class DioInterceptors {
  DioInterceptors._();

  static InterceptorsWrapper getAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        _logRequest(options);

        return handler.next(options);
      },
      onResponse: (response, handler) {
        _logResponse(response);

        return handler.next(response);
      },
      onError: (error, handler) {
        _logError(error);

        return handler.next(error);
      },
    );
  }

  static LogInterceptor getLoggingInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (log) {
        log;
      },
    );
  }

  static void _logRequest(RequestOptions options) {
    log('┌─────────────────────────────────────────────────────────────────');
    log('│ REQUEST');
    log('├─────────────────────────────────────────────────────────────────');
    log('│ ${options.method} ${options.uri}');
    log('│ Headers: ${options.headers}');
    if (options.data != null) {
      log('│ Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      log('│ Query Parameters: ${options.queryParameters}');
    }
    log('└─────────────────────────────────────────────────────────────────');
  }

  static void _logResponse(Response response) {
    log('┌─────────────────────────────────────────────────────────────────');
    log('│ RESPONSE');
    log('├─────────────────────────────────────────────────────────────────');
    log('│ ${response.statusCode} ${response.requestOptions.uri}');
    log('│ Headers: ${response.headers}');
    log('│ Body: ${response.data}');
    log('└─────────────────────────────────────────────────────────────────');
  }

  static void _logError(DioException error) {
    log('┌─────────────────────────────────────────────────────────────────');
    log('│ ERROR');
    log('├─────────────────────────────────────────────────────────────────');
    log('│ ${error.requestOptions.method} ${error.requestOptions.uri}');
    log('│ Type: ${error.type}');
    log('│ Message: ${error.message}');
    if (error.response != null) {
      log('│ Status Code: ${error.response?.statusCode}');
      log('│ Response: ${error.response?.data}');
    }
    log('└─────────────────────────────────────────────────────────────────');
  }
}
