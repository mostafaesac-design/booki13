import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/core/widgets/app_text_field.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/features/auth/ui/password_changed_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key, required this.code});
  final String code;

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void resetPassword() {
    FocusScope.of(context).unfocus();

    final password = passwordController.text;
    final confirmation = confirmPasswordController.text;
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must contain at least 8 characters.'),
        ),
      );
      return;
    }
    if (password != confirmation) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password confirmation does not match.')),
      );
      return;
    }
    context.read<AuthCubit>().resetPassword(
      code: widget.code,
      password: password,
      passwordConfirmation: confirmation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const PasswordChangedScreen()),
            (route) => route.isFirst,
          );
        } else if (state is ResetPasswordErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final loading = state is ResetPasswordLoadingState;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Create new password',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Your new password must contain at least 8 characters.',
                      style: TextStyle(fontSize: 16.sp, color: AppColors.hint),
                    ),
                    SizedBox(height: 36.h),
                    AppTextField(
                      hintText: 'New Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 32.h),
                    AppButton(
                      text: loading ? 'Resetting...' : 'Reset Password',
                      onTap: loading ? null : resetPassword,
                    ),
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
