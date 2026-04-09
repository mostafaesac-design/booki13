import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helper/app_constants.dart';

class AuthRepo {
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioService.dio?.post(
        ApiConstants.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response?.statusCode == 200 &&
          response?.data["data"] != null &&
          response?.data["data"]["token"] != null) {
        await saveUserToken(response?.data["data"]["token"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioService.dio?.post(
        ApiConstants.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );

      if (response?.statusCode == 201 &&
          response?.data["data"] != null &&
          response?.data["data"]["token"] != null) {
        await saveUserToken(response?.data["data"]["token"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Register Error: $e");
      return false;
    }
  }

  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    AppConstants.token = token;
    print("successfully");
  }

}