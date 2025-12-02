import 'package:flutter_task/core/networking/exceptions/api_exception.dart';

sealed class ApiResult<T> {
  const ApiResult();

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(ApiException exception) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else {
      return failure((this as Failure<T>).exception);
    }
  }

  R? whenSuccess<R>(R Function(T data) fn) {
    if (this is Success<T>) {
      return fn((this as Success<T>).data);
    }
    return null;
  }

  R? whenFailure<R>(R Function(ApiException exception) fn) {
    if (this is Failure<T>) {
      return fn((this as Failure<T>).exception);
    }
    return null;
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);

  @override
  String toString() => 'Success(data: $data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success && runtimeType == other.runtimeType && data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class Failure<T> extends ApiResult<T> {
  final ApiException exception;

  const Failure(this.exception);

  @override
  String toString() => 'Failure(exception: $exception)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          exception == other.exception;

  @override
  int get hashCode => exception.hashCode;
}
