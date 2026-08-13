import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/features/auth/ui/create_new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyResetCodeSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<AuthCubit>(),
                child: CreateNewPasswordScreen(
                  code: codeController.text.trim(),
                ),
              ),
            ),
          );
        } else if (state is VerifyResetCodeErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ForgotPasswordSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('A new code was sent.')));
        } else if (state is ForgotPasswordErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final loading =
            state is VerifyResetCodeLoadingState ||
            state is ForgotPasswordLoadingState;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Enter the 6-digit code sent to ${widget.email}.',
                    style: TextStyle(fontSize: 16.sp, color: AppColors.hint),
                  ),
                  SizedBox(height: 36.h),
                  TextField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontSize: 24.sp,
                      letterSpacing: 12.w,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '000000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  AppButton(
                    text: loading ? 'Please wait...' : 'Verify',
                    onTap: loading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();

                            final code = codeController.text.trim();

                            if (code.length != 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Enter the complete 6-digit code.',
                                  ),
                                ),
                              );
                              return;
                            }

                            context.read<AuthCubit>().verifyResetCode(
                              email: widget.email,
                              code: code,
                            );
                          },
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton(
                      onPressed: loading
                          ? null
                          : () => context.read<AuthCubit>().forgetPassword(
                              widget.email,
                            ),
                      child: const Text("Didn't receive the code? Resend"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
