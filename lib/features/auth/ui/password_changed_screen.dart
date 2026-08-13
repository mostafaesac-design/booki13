import 'package:flutter/material.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';

// عدل حسب مكانك
// import 'package:bookstore/core/widgets/app_button.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 180.h),

              Container(
                width: 110.w,
                height: 110.h,
                decoration: const BoxDecoration(
                  color: AppColors.successAlt,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 60.sp,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 32.h),

              Text(
                'Password Changed!',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 16.h),

              SizedBox(
                width: 280.w,
                child: Text(
                  'Your password has been changed successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                    color: AppColors.hint,
                  ),
                ),
              ),

              SizedBox(height: 48.h),

              /// استبدله بزرارك من core
              /// AppButton(
              ///   text: 'Back to Login',
              ///   onTap: () {
              ///     Navigator.pushAndRemoveUntil(
              ///       context,
              ///       MaterialPageRoute(
              ///         builder: (context) => const LoginScreen(),
              ///       ),
              ///       (route) => false,
              ///     );
              ///   },
              /// )
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
