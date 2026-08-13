import 'package:bookstore/core/helper/app_constants.dart';
import 'package:bookstore/core/routes/routes.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gen/assets.gen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _continueTo(BuildContext context, String routeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.hasSeenWelcomeKey, true);
    AppConstants.hasSeenWelcome = true;

    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.welcomeBackground.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 35.h),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (context.locale.languageCode == "ar") {
                      context.setLocale(Locale("en"));
                    } else {
                      context.setLocale(Locale("ar"));
                    }
                  },
                  icon: Icon(Icons.language),
                ),
              ],
            ),
            SizedBox(height: 100.h),
            Assets.images.splash.image(),
            SizedBox(height: 28.h),
            Expanded(
              child: Text(
                LocaleKeys.welcomeMessage.tr(),
                style: TextStyle(fontSize: 20.sp),
              ),
            ),

            AppButton(
              text: LocaleKeys.login.tr(),
              onTap: () {
                _continueTo(context, Routes.loginScreen);
              },
            ),
            SizedBox(height: 15.h),
            AppButton(
              text: LocaleKeys.register.tr(),
              onTap: () {
                _continueTo(context, Routes.registerScreen);
              },
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 94.h),
          ],
        ),
      ),
    );
  }
}
