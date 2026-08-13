import 'package:flutter/material.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/core/widgets/app_page_header.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/profile_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;
  bool obscure3 = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration buildInput(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              AppPageHeader(title: 'change_password'.tr()),
              SizedBox(height: 60.h),
              Text(
                'New Password',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 30.h),
              TextField(
                controller: currentPasswordController,
                obscureText: obscure1,
                decoration: buildInput(
                  'Current Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure1 = !obscure1;
                      });
                    },
                    icon: Icon(
                      obscure1 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: newPasswordController,
                obscureText: obscure2,
                decoration: buildInput(
                  'New Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure2 = !obscure2;
                      });
                    },
                    icon: Icon(
                      obscure2 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: confirmPasswordController,
                obscureText: obscure3,
                decoration: buildInput(
                  'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure3 = !obscure3;
                      });
                    },
                    icon: Icon(
                      obscure3 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'change_password'.tr(),
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  final currentPassword = currentPasswordController.text.trim();
                  final newPassword = newPasswordController.text.trim();
                  final confirmPassword = confirmPasswordController.text.trim();

                  if (currentPassword.isEmpty ||
                      newPassword.isEmpty ||
                      confirmPassword.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Please complete all password fields.'),
                        ),
                      );
                    return;
                  }

                  if (newPassword.length < 8) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'New password must contain at least 8 characters.',
                          ),
                        ),
                      );
                    return;
                  }

                  if (newPassword != confirmPassword) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password confirmation does not match.',
                          ),
                        ),
                      );
                    return;
                  }

                  final result = await context
                      .read<ProfileCubit>()
                      .updatePassword(
                        currentPassword: currentPassword,
                        newPassword: newPassword,
                        confirmPassword: confirmPassword,
                      );

                  if (!context.mounted) return;

                  if (result) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: const Text('Password updated successfully.'),
                        ),
                      );
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'The current password is incorrect or the update failed.',
                          ),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
