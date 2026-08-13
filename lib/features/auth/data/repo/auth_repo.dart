import 'package:bookstore/core/helper/app_constants.dart';
import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/core/networking/api_result.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static const String userEmailKey = 'current_user_email';

  static Future<ApiResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioService.dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = response.data['data']?['token'];

      if (response.statusCode == 200 && token is String) {
        await saveUserSession(
          token: token,
          email: email,
        );

        return const ApiSuccess<void>(null);
      }

      return const ApiFailure<void>(
        'Login failed. Please try again.',
      );
    } catch (error) {
      return ApiFailure<void>(
        ApiErrorHandler.getMessage(error),
      );
    }
  }

  static Future<ApiResult> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioService.dio.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      final token = response.data['data']?['token'];

      if (response.statusCode == 201 && token is String) {
        await saveUserSession(
          token: token,
          email: email,
        );

        return const ApiSuccess<void>(null);
      }

      return const ApiFailure<void>(
        'Registration failed. Please try again.',
      );
    } catch (error) {
      return ApiFailure<void>(
        ApiErrorHandler.getMessage(error),
      );
    }
  }

  static Future<void> saveUserSession({
    required String token,
    required String email,
  }) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      AppConstants.tokenKey,
      token,
    );

    await prefs.setString(
      userEmailKey,
      email.trim().toLowerCase(),
    );

    AppConstants.token = token;
  }

  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      AppConstants.tokenKey,
      token,
    );

    AppConstants.token = token;
  }

  static Future<String?> getCurrentUserEmail() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    return prefs.getString(userEmailKey);
  }

  static Future<ApiResult> forgetPassword(String email) async {
    try {
      final response = await DioService.dio.post(
        ApiConstants.forgetPassword,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return const ApiSuccess<void>(null);
      }

      return const ApiFailure<void>(
        'Unable to send the verification code.',
      );
    } catch (error) {
      return ApiFailure<void>(
        ApiErrorHandler.getMessage(error),
      );
    }
  }

  static Future<ApiResult> checkForgetPasswordCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await DioService.dio.post(
        ApiConstants.checkForgetPassword,
        data: {
          'email': email,
          'verify_code': code,
        },
      );

      if (response.statusCode == 200) {
        return const ApiSuccess<void>(null);
      }

      return const ApiFailure<void>(
        'The verification code is incorrect.',
      );
    } catch (error) {
      return ApiFailure<void>(
        ApiErrorHandler.getMessage(error),
      );
    }
  }

  static Future<ApiResult> resetPassword({
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioService.dio.post(
        ApiConstants.resetPassword,
        data: {
          'verify_code': code,
          'new_password': password,
          'new_password_confirmation': passwordConfirmation,
        },
      );

      if (response.statusCode == 200) {
        return const ApiSuccess<void>(null);
      }

      return const ApiFailure<void>(
        'Unable to reset the password.',
      );
    } catch (error) {
      return ApiFailure<void>(
        ApiErrorHandler.getMessage(error),
      );
    }
  }
}