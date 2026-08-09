import 'package:dio/dio.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static String getMessage(Object error) {
    if (error is! DioException) {
      return 'Something went wrong. Please try again.';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.cancel:
        return 'The request was cancelled.';
      case DioExceptionType.badResponse:
        return _responseMessage(error.response);
      case DioExceptionType.badCertificate:
        return 'Could not establish a secure connection.';
      case DioExceptionType.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  static String _responseMessage(Response<dynamic>? response) {
    final data = response?.data;
    if (data is Map) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }

      final errors = data['errors'];
      if (errors is Map) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) return value.first.toString();
          if (value is String && value.isNotEmpty) return value;
        }
      }
    }

    switch (response?.statusCode) {
      case 401:
        return 'Your email or password is incorrect.';
      case 403:
        return 'You are not allowed to perform this action.';
      case 404:
        return 'The requested data was not found.';
      case 422:
        return 'Please check the entered data.';
      default:
        return 'Server error. Please try again later.';
    }
  }
}
