import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  InputDecoration buildInput(
      String hint, {
        Widget? suffixIcon,
      }) {
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
      backgroundColor: const Color(0xffF9F5FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              Text(
                'New Password',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
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
                    icon: Icon(obscure1 ? Icons.visibility_off : Icons.visibility),
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
                    icon: Icon(obscure2 ? Icons.visibility_off : Icons.visibility),
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
                    icon: Icon(obscure3 ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await context.read<ProfileCubit>().updatePassword(
                      currentPassword: currentPasswordController.text.trim(),
                      newPassword: newPasswordController.text.trim(),
                      confirmPassword: confirmPasswordController.text.trim(),
                    );

                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password updated successfully')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Wrong current password or confirm failed')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC7A84B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Update Password',
                    style: TextStyle(
                      fontSize: 18.sp,
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