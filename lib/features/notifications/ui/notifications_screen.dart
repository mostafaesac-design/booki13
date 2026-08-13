import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_page_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              AppPageHeader(title: 'notifications'.tr()),
              const Expanded(child: Center(child: Text('Notification Screen'))),
            ],
          ),
        ),
      ),
    );
  }
}
