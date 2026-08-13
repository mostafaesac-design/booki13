import 'dart:io';
import 'package:bookstore/core/helper/app_constants.dart';
import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/core/networking/api_result.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:bookstore/features/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  Future<ProfileModel> getProfile() async =>
      _profile((await DioService.dio.get(ApiConstants.profile)).data);

  Future<ProfileModel> updateProfile({
    required String name,
    required String phone,
    required String address,
    required String imagePath,
  }) async {
    final values = <String, dynamic>{
      'name': name,
      'phone': phone,
      'address': address,
    };
    if (imagePath.isNotEmpty &&
        !imagePath.startsWith('http') &&
        File(imagePath).existsSync()) {
      values['image'] = await MultipartFile.fromFile(imagePath);
    }
    return _profile(
      (await DioService.dio.post(
        ApiConstants.updateProfile,
        data: FormData.fromMap(values),
      )).data,
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await DioService.dio.post(
      ApiConstants.updatePassword,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
    );
  }

  Future<void> deleteAccount(String currentPassword) async {
    await DioService.dio.post(
      ApiConstants.deleteProfile,
      data: FormData.fromMap({'current_password': currentPassword}),
    );
    await _clearSession();
  }

  Future<ApiResult<bool>> logout() async {
    try {
      await DioService.dio.post(ApiConstants.logout);
    } catch (error) {
      // The server request must not prevent the user from logging out locally.
      // The saved wishlist remains untouched and is still tied to the account.
    }

    try {
      await _clearSession();
      return const ApiSuccess<bool>(true);
    } catch (error) {
      return ApiFailure<bool>(ApiErrorHandler.getMessage(error));
    }
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove('current_user_email');
    AppConstants.token = '';
  }

  ProfileModel _profile(dynamic responseData) {
    final envelope = responseData is Map ? responseData : const {};
    final data = envelope['data'];
    return ProfileModel.fromJson(
      data is Map ? Map<String, dynamic>.from(data) : const {},
    );
  }
}
