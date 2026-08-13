import 'package:bookstore/features/auth/data/repo/auth_repo.dart';
import 'package:bookstore/core/networking/api_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.login(email: email, password: password);
    if (response is ApiSuccess<void>) {
      emit(AuthSuccessState());
    } else if (response is ApiFailure<void>) {
      emit(AuthErrorState(response.message));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoadingState());

    final response = await AuthRepo.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (response is ApiSuccess<void>) {
      emit(AuthSuccessState());
    } else if (response is ApiFailure<void>) {
      emit(AuthErrorState(response.message));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(ForgotPasswordLoadingState());
    final result = await AuthRepo.forgetPassword(email);
    if (result is ApiSuccess<void>) {
      emit(ForgotPasswordSuccessState());
    } else if (result is ApiFailure<void>) {
      emit(ForgotPasswordErrorState(result.message));
    }
  }

  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    emit(VerifyResetCodeLoadingState());
    final result = await AuthRepo.checkForgetPasswordCode(
      email: email,
      code: code,
    );
    if (result is ApiSuccess<void>) {
      emit(VerifyResetCodeSuccessState());
    } else if (result is ApiFailure<void>) {
      emit(VerifyResetCodeErrorState(result.message));
    }
  }

  Future<void> resetPassword({
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoadingState());
    final result = await AuthRepo.resetPassword(
      code: code,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (result is ApiSuccess<void>) {
      emit(ResetPasswordSuccessState());
    } else if (result is ApiFailure<void>) {
      emit(ResetPasswordErrorState(result.message));
    }
  }
}
