import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/features/auth/ui/create_new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
                          'OTP Verification',
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
                            'Enter the verification code we just sent on your email address.',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                              color: const Color(0xFF8391A1),
                            ),
                          ),
                        ),

                        SizedBox(height: 36.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            5,
                                (index) => Container(
                              width: 58.w,
                              height: 58.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFBFA054),
                                  width: 1.w,
                                ),
                                color: Colors.white,
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        AppButton(text: "Verify",

                          onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const CreateNewPasswordScreen(),
                            ),
                          );
                        },
                        ),

                        const Spacer(),

                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E1E1E),
                              ),
                              children: const [
                                TextSpan(text: "Didn’t received code? "),
                                TextSpan(
                                  text: 'Resend',
                                  style: TextStyle(
                                    color: Color(0xFFBFA054),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
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