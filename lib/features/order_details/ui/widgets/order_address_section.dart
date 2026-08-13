import 'package:bookstore/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderAddressSection extends StatelessWidget {
  final String title;
  final String details;
  final VoidCallback onEditAddress;
  final VoidCallback onAddNote;

  const OrderAddressSection({
    super.key,
    required this.title,
    required this.details,
    required this.onEditAddress,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'delivery_address'.tr(),
          style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20.h),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4.h),
        Text(
          details,
          style: TextStyle(
            fontSize: 13.sp,
            height: 1.35,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            _AddressActionButton(
              icon: Icons.edit_outlined,
              label: 'edit_address'.tr(),
              onTap: onEditAddress,
            ),
            _AddressActionButton(
              icon: Icons.note_alt_outlined,
              label: 'add_note'.tr(),
              onTap: onAddNote,
            ),
          ],
        ),
      ],
    );
  }
}

class _AddressActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AddressActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColors.textSecondary),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp),
            SizedBox(width: 5.w),
            Text(
              label,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
