import 'package:bookstore/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationsTap;

  const HomeAppBar({
    super.key,
    required this.onSearchTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.splash.image(width: 100.w),
        Row(
          children: [
            IconButton(
              onPressed: onNotificationsTap,
              icon: Icon(Icons.notifications_none_rounded, size: 24.sp),
            ),
            IconButton(
              onPressed: onSearchTap,
              icon: Icon(Icons.search, size: 24.sp, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
