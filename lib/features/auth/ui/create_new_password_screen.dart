import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/core/widgets/app_text_field.dart';
import 'package:bookstore/features/auth/ui/password_changed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFE8ECF4),
                      width: 1.w,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18.sp,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ),

                SizedBox(height: 48.h),

                Text(
                  'Create new password',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),

                SizedBox(height: 12.h),

                SizedBox(
                  width: 320.w,
                  child: Text(
                    'Your new password must be unique from those previously used.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                      color: const Color(0xFF8391A1),
                    ),
                  ),
                ),

                SizedBox(height: 36.h),


                AppTextField(hintText: "New Password"),

                SizedBox(height: 16.h),

                AppTextField(hintText: "Confirm Password"),

                SizedBox(height: 32.h),

              AppButton(text: "Reset Password",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordChangedScreen(),
                    ),
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}