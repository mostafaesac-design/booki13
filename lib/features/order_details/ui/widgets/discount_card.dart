import 'package:bookstore/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountCard extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const DiscountCard({super.key, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Icon(
              Icons.discount_outlined,
              color: AppColors.primary,
              size: 21.sp,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                'discount_applied'.tr(args: ['$count']),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 17.sp),
          ],
        ),
      ),
    );
  }
}
