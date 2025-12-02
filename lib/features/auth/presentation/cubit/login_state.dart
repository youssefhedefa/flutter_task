import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';

class LoginState extends Equatable {
  final RequestStatusEnum status;
  final String? errorMessage;

  const LoginState({
    required this.status,
    this.errorMessage,
  });

  factory LoginState.initial() {
    return const LoginState(
      status: RequestStatusEnum.initial,
    );
  }

  LoginState copyWith({
    RequestStatusEnum? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
