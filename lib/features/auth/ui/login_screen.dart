import 'package:bookstore/core/routes/routes.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/core/widgets/app_text_field.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/features/auth/ui/widgets/social_button.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  set isPasswordObscure(bool isPasswordObscure) {}
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120.h),

                  SizedBox(
                    width: 250.w,
                    child: Text(
                      LocaleKeys.welcomeBack.tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3.h,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  AppTextField(
                    controller: emailController,
                    hintText: LocaleKeys.enterEmail.tr(),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      final email = value?.trim() ?? '';

                      if (email.isEmpty) {
                        return 'Please enter your email';
                      }

                      final emailPattern = RegExp(
                        r'^[\w.%+-]+@[\w.-]+\.[A-Za-z]{2,}$',
                      );

                      if (!emailPattern.hasMatch(email)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),

                  AppTextField(
                    controller: passwordController,
                    hintText: LocaleKeys.enterPassword.tr(),
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 12.h),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgotPasswordScreen);
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

                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoadingState) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is AuthErrorState) {
                        Navigator.pop(context);

                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Error"),
                            content: Text("Login Failed"),
                          ),
                        );
                      } else if (state is AuthSuccessState) {
                        Navigator.pop(context);

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.bottomNavBarScreen,
                          (route) => false,
                        );
                      }
                    },

                    child: AppButton(
                      text: LocaleKeys.login.tr(),
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        context.read<AuthCubit>().login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1.h)),
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
                      Expanded(child: Divider(thickness: 1.h)),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  SocialButton(
                    text: LocaleKeys.signInGoogle.tr(),
                    iconWidget: SvgPicture.asset(
                      'assets/icons/googleicon.svg',
                      width: 26.w,
                      height: 26.w,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) => Icon(
                        Icons.error,
                        size: 26.sp,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {},
                  ),

                  SizedBox(height: 95.h),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.registerScreen,
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'noAccount'.tr(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: LocaleKeys.register_now.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
