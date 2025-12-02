import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_task/core/networking/exceptions/api_exception.dart';

class ApiExceptionHandler {
  ApiExceptionHandler._();

  static ApiException handleException(dynamic error) {
    log('ApiExceptionHandler: Handling error: $error');
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException(
            message: error.message ?? 'Request timeout',
          );

        case DioExceptionType.connectionError:
          return NetworkException(
            message: error.message ?? 'No internet connection',
          );

        case DioExceptionType.badResponse:
          return _handleResponseError(error);

        case DioExceptionType.cancel:
          return CancelledException(
            message: error.message ?? 'Request cancelled',
          );

        case DioExceptionType.badCertificate:
          return UnknownException(
            message: 'Certificate verification failed',
          );

        case DioExceptionType.unknown:
          return NetworkException(
            message: error.message ?? 'Unknown network error',
          );
      }
    } else {
      return UnknownException(
        message: error.toString(),
      );
    }
  }

  static ApiException _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    final message =
        _extractErrorMessage(data) ?? error.message ?? 'An error occurred';

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 401:
        return UnauthorizedException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 403:
        return ForbiddenException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 404:
        return NotFoundException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 500:
        return InternalServerException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 503:
        return ServiceUnavailableException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      default:
        return UnknownException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
    }
  }

  static String? _extractErrorMessage(dynamic data) {

    if (data == null) return null;

    // Handle plain text responses first (e.g., "username or password is incorrect")
    if (data is String) {
      return data.trim().isNotEmpty ? data.trim() : null;
    }

    // Handle JSON/Map responses
    if (data is Map) {
      // Try 'message' key
      if (data.containsKey('message')) {
        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message.trim();
        }
      }

      // Try 'error' key
      if (data.containsKey('error')) {
        final error = data['error'];
        if (error is String && error.trim().isNotEmpty) {
          return error.trim();
        }
        if (error is Map && error.containsKey('message')) {
          final errorMessage = error['message'];
          if (errorMessage is String && errorMessage.trim().isNotEmpty) {
            return errorMessage.trim();
          }
        }
      }

      // Try 'msg' key
      if (data.containsKey('msg')) {
        final msg = data['msg'];
        if (msg is String && msg.trim().isNotEmpty) {
          return msg.trim();
        }
      }

      // Try 'errors' key (array or object)
      if (data.containsKey('errors')) {
        final errors = data['errors'];
        if (errors is List && errors.isNotEmpty) {
          return errors.first.toString().trim();
        }
        if (errors is Map) {
          final firstError = errors.values.firstOrNull;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString().trim();
          }
          if (firstError != null) {
            return firstError.toString().trim();
          }
        }
      }
    }

    return null;
  }
}
