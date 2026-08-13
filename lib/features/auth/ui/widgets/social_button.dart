import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    this.icon,
    this.iconWidget,
    required this.onTap,
  });

  final String text;
  final String? icon;
  final Widget? iconWidget;
  final VoidCallback onTap;

  Widget _buildIcon() {
    if (iconWidget != null) {
      return iconWidget!;
    }

    if (icon != null && icon!.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        icon!,
        width: 24.w,
        height: 24.h,
        fit: BoxFit.contain,
      );
    }

    return Text(
      icon ?? '',
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.border,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            SizedBox(width: 10.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}