import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const SupportScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
          child: Column(
            children: [
              AppPageHeader(title: title),
              SizedBox(height: 22.h),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
