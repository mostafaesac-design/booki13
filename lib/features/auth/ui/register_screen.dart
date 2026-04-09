import 'package:bookstore/core/routes/routes.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/app_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register(BuildContext context) {
    if (userNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    context.read<AuthCubit>().register(
      name: userNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: confirmPasswordController.text.trim(),
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
    const Color titleColor = Color(0xFF1E1E1E);
    const Color borderColor = Color(0xFFE8ECF4);
    const Color primaryColor = Color(0xFFC49E47);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBarScreen,
                (route) => false,
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register failed'),
            ),
          );
        }
      },
      builder: (context, state) {
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
                          color: borderColor,
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
                    ),

                    SizedBox(height: 16.h),

                    AppTextField(
                        hintText: LocaleKeys.email.tr(),
                        controller: emailController,
                    ),

                    SizedBox(height: 16.h),

                    AppTextField(
                      hintText: LocaleKeys.password.tr(),
                      controller: passwordController,
                      isPassword: true,
                    ),

                    SizedBox(height: 16.h),

                    AppTextField(
                        hintText: LocaleKeys.confirmPassword.tr(),
                        controller: confirmPasswordController,
                    ),

                    SizedBox(height: 30.h),


                    AppButton(
                      text: state is AuthLoadingState
                          ? 'Loading...'
                          : LocaleKeys.register.tr(),
                      onTap: state is AuthLoadingState
                          ? null
                          : () {
                        register(context);
                      },
                    ),

                    SizedBox(height: 260.h),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: titleColor,
                            ),
                            children: const [
                              TextSpan(text: 'Already have an account? '),
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

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}