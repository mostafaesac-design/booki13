import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/core/widgets/app_text_field.dart';
import 'package:bookstore/features/auth/ui/register_screen.dart';
import 'package:bookstore/features/auth/ui/widgets/social_button.dart';
import 'package:bookstore/features/forgotPassword/ui/forgot_password_screen.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  set isPasswordObscure(bool isPasswordObscure) {}
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  var  emailController = TextEditingController();
  var  passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    ),
                  ),
                ),

                SizedBox(height: 28.h),

                SizedBox(
                  width: 250.w,
                  child: Text(LocaleKeys.welcomeBack.tr(),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.3.h,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                AppTextField(
                controller: emailController
                ,hintText: LocaleKeys.enterEmail.tr()),

                SizedBox(height: 16.h),

                AppTextField(
                controller: passwordController,
                hintText: LocaleKeys.enterPassword.tr(),
                  isPassword: true,
                ),

                SizedBox(height: 12.h),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      LocaleKeys.forgotPassword.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

               AppButton(
                 text: LocaleKeys.login.tr(),
               ),


                SizedBox(height: 15.h),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(text: LocaleKeys.haveAccount,style: TextStyle(fontSize: 15.sp,color: AppColors.titleColor)),
                          TextSpan(
                            text: LocaleKeys.register_now.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.h),


                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        LocaleKeys.or.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1.h,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                SocialButton(
                  text: LocaleKeys.signInGoogle.tr(),
                  icon: 'G',
                  onTap: () {},
                ),

                SizedBox(height: 16.h),

                SocialButton(
                  text: LocaleKeys.signInApple.tr(),
                  iconWidget: Icon(
                    Icons.apple,
                    size: 24.sp,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),

                SizedBox(height: 80.h),

              ],
            ),
          ),
        ),
      ),
    );
  }

  login(){

    Dio dio=Dio();
    dio.patch("https://mostafaesac-739873.postman.co/workspace/Mostafa-Isaac's-Workspace~e3c8c603-4ea7-41da-82a3-dbd825d8efdf/request/53203838-b2d69460-8385-425a-b22b-b7d4feecc6c7?action=share&creator=53203838");
  }
}

