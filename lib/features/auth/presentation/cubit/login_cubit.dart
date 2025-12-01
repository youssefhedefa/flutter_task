import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_task/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase,
       super(LoginState.initial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatusEnum.loading));

    final result = await _loginUseCase.call(
      username: username,
      password: password,
    );

    result.when(
      success: (_) {
        // Token is already saved in repository, just emit success
        emit(state.copyWith(status: RequestStatusEnum.success));
      },
      failure: (exception) {
        emit(
          state.copyWith(
            status: RequestStatusEnum.failure,
            errorMessage: exception.message,
          ),
        );
      },
    );
  }
}
