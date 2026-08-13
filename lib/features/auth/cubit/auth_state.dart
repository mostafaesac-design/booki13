part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccessState extends AuthState {}

final class AuthErrorState extends AuthState {
  AuthErrorState(this.message);

  final String message;
}

final class AuthLoadingState extends AuthState {}

final class ForgotPasswordLoadingState extends AuthState {}

final class ForgotPasswordSuccessState extends AuthState {}

final class ForgotPasswordErrorState extends AuthState {
  ForgotPasswordErrorState(this.message);
  final String message;
}

final class VerifyResetCodeLoadingState extends AuthState {}

final class VerifyResetCodeSuccessState extends AuthState {}

final class VerifyResetCodeErrorState extends AuthState {
  VerifyResetCodeErrorState(this.message);
  final String message;
}

final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSuccessState extends AuthState {}

final class ResetPasswordErrorState extends AuthState {
  ResetPasswordErrorState(this.message);
  final String message;
}
