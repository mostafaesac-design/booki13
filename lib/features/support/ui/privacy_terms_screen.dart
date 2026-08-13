import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/support/ui/widgets/support_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SupportScaffold(
      title: 'privacy_terms'.tr(),
      child: ListView(
        padding: EdgeInsets.only(bottom: 24.h),
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 22.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'terms_title_${index + 1}'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'terms_body_${index + 1}'.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
