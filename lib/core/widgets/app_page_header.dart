import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPageHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final bool showBackButton;

  const AppPageHeader({
    super.key,
    required this.title,
    this.trailing,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 42.w,
          child: showBackButton ? const AppBackButton() : null,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 42.w, child: trailing),
      ],
    );
  }
}
