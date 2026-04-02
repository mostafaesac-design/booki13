import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/core/widgets/app_text_field.dart';
import 'package:bookstore/features/auth/ui/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
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
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Don't worry! It occurs. Please enter the email\naddress linked with your account.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                              color: const Color(0xFF8391A1),
                            ),
                          ),
                        ),

                        SizedBox(height: 36.h),
                          AppTextField(hintText: "Enter your email"),


                        SizedBox(height: 30.h),

                      AppButton(text: "Send Code",onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            OtpVerificationScreen(),
                          ),
                        );
                      },),


                        const Spacer(),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E1E1E),
                                ),
                                children: const [
                                  TextSpan(text: 'Remember Password? '),
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Color(0xFFBFA054),
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
              );
            },
          ),
        ),
      ),
    );
  }
}