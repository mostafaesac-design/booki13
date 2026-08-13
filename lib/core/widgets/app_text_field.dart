import 'package:bookstore/core/theme/app_text_style.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../gen/assets.gen.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  // final Widget? suffixIcon;
  final bool isPassword;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.isPassword = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapUpOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && isObscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyle.hintStyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? Padding(
                padding: EdgeInsets.all(8.0.r),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child: isObscure
                      ? SvgPicture.asset(Assets.images.fluentEye20Filled)
                      : Icon(Icons.visibility_off),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.border, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryFocused, width: 1.2.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.2.w),
        ),
      ),
    );
  }
}
