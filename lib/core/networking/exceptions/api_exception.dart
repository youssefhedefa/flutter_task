import '../../constants/app_strings.dart';

abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException({
    super.message = AppStrings.networkError,
    super.statusCode,
    super.data,
  });
}

class TimeoutException extends ApiException {
  TimeoutException({
    super.message = AppStrings.timeoutError,
    super.statusCode,
    super.data,
  });
}

class BadRequestException extends ApiException {
  BadRequestException({
    super.message = AppStrings.badRequestError,
    super.statusCode = 400,
    super.data,
  });
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({
    super.message = AppStrings.unauthorizedError,
    super.statusCode = 401,
    super.data,
  });
}

class ForbiddenException extends ApiException {
  ForbiddenException({
    super.message = AppStrings.forbiddenError,
    super.statusCode = 403,
    super.data,
  });
}

class NotFoundException extends ApiException {
  NotFoundException({
    super.message = AppStrings.notFoundError,
    super.statusCode = 404,
    super.data,
  });
}

class InternalServerException extends ApiException {
  InternalServerException({
    super.message = AppStrings.internalServerError,
    super.statusCode = 500,
    super.data,
  });
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException({
    super.message = AppStrings.serviceUnavailableError,
    super.statusCode = 503,
    super.data,
  });
}

class UnknownException extends ApiException {
  UnknownException({
    super.message = AppStrings.unknownError,
    super.statusCode,
    super.data,
  });
}

class CancelledException extends ApiException {
  CancelledException({
    super.message = AppStrings.cancelledError,
    super.statusCode,
    super.data,
  });
}
