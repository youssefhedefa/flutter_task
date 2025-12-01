import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/splash/domain/usecases/check_auth_usecase.dart';
import 'package:flutter_task/features/splash/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckAuthUseCase _checkAuthUseCase;

  SplashCubit({required CheckAuthUseCase checkAuthUseCase})
      : _checkAuthUseCase = checkAuthUseCase,
        super(const SplashState());

  Future<void> checkAuthentication() async {
    emit(state.copyWith(status: SplashStatus.loading));

    // Add a small delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 2));

    try {
      final isAuthenticated = await _checkAuthUseCase.execute();

      if (isAuthenticated) {
        emit(state.copyWith(status: SplashStatus.authenticated));
      } else {
        emit(state.copyWith(status: SplashStatus.unauthenticated));
      }
    } catch (e) {
      // If there's an error checking auth, treat as unauthenticated
      emit(state.copyWith(
        status: SplashStatus.unauthenticated,
        errorMessage: e.toString(),
      ));
    }
  }
}

