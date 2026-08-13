import 'package:bookstore/core/routes/routes.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/core/widgets/app_text_field.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<AuthCubit>().register(
      name: userNameController.text.trim(),
      email: emailController.text.trim().toLowerCase(),
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color titleColor = AppColors.textPrimary;
    const Color borderColor = AppColors.border;
    const Color primaryColor = AppColors.primaryFocused;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBarScreen,
            (route) => false,
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: borderColor, width: 1.w),
                        ),
                        child: IconButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.loginScreen,
                                  );
                                },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18.sp,
                            color: titleColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      SizedBox(
                        width: 260.w,
                        child: Text(
                          LocaleKeys.helloRegister.tr(),
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: titleColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      AppTextField(
                        hintText: LocaleKeys.username.tr(),
                        controller: userNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }

                          if (value.trim().length < 2) {
                            return 'Name must contain at least 2 characters';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      AppTextField(
                        hintText: LocaleKeys.email.tr(),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          final email = value?.trim() ?? '';

                          final emailPattern = RegExp(
                            r'^[A-Za-z0-9.!#$%&*+/=?^_`{|}~-]+'
                            r'@[A-Za-z0-9-]+'
                            r'(\.[A-Za-z0-9-]+)+$',
                          );

                          if (email.isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!emailPattern.hasMatch(email)) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      AppTextField(
                        hintText: LocaleKeys.password.tr(),
                        controller: passwordController,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }

                          if (value.length < 8) {
                            return 'Password must contain at least 8 characters';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      AppTextField(
                        hintText: LocaleKeys.confirmPassword.tr(),
                        controller: confirmPasswordController,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }

                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),

                      AppButton(
                        text: isLoading
                            ? 'Loading...'
                            : LocaleKeys.register.tr(),
                        onTap: isLoading
                            ? null
                            : () {
                                register(context);
                              },
                      ),

                      SizedBox(height: 150.h),

                      Center(
                        child: GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.loginScreen,
                                  );
                                },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: titleColor,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Already have an account? ',
                                ),
                                TextSpan(
                                  text: 'Login Now',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
