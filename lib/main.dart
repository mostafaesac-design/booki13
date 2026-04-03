import 'package:bookstore/book_store_app.dart';
import 'package:bookstore/core/helper/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  AppConstants.token=prefs.getString("token");
  runApp(
      EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: BookStoreApp()));
}




// flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
// dart run build_runner build --delete-conflicting-outputs
// flutter pub add flutter_native_splash
// flutter pub add flutter_screenutil


